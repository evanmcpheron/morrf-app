import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/enums/severity.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/core/widgets/morrf_button.dart';
import 'package:morrf/features/services/add_service/controller/service_controller.dart';
import 'package:morrf/features/splash_screen/screens/redirect_splash_screen.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:nb_utils/nb_utils.dart';

class CreateNewServicePublishScreen extends ConsumerStatefulWidget {
  final bool isVisible;
  final Function(int page) pageChange;
  final MorrfService morrfService;

  const CreateNewServicePublishScreen(
      {super.key,
      required this.isVisible,
      required this.pageChange,
      required this.morrfService});

  @override
  ConsumerState<CreateNewServicePublishScreen> createState() =>
      _CreateNewServicePublishScreenState();
}

class _CreateNewServicePublishScreenState
    extends ConsumerState<CreateNewServicePublishScreen> {
  int currentImage = 0;
  ScrollController? _scrollController;
  double height = 200;

  void _onSubmit() async {
    try {
      ref
          .read(serviceControllerProvider.notifier)
          .createService(widget.morrfService);
      const snackBar = SnackBar(
        content: MorrfText(
            text: 'Published Successfully!',
            size: FontSize.h5,
            textAlign: TextAlign.center),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Get.offAll(
      //   () => const RedirectSplashScreen(),
      // );
    } catch (e) {
      rethrow;
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 20.0),
        Row(
          children: [
            MorrfButton(
              onPressed: () {
                widget.pageChange(4);
              },
              width: MediaQuery.of(context).size.width / 2 - 23,
              text: "Back",
            ),
            const SizedBox(
              width: 16,
            ),
            MorrfButton(
              severity: Severity.success,
              onPressed: () {
                _onSubmit();
              },
              width: MediaQuery.of(context).size.width / 2 - 23,
              text: "Next",
            ),
          ],
        ),
        SizedBox(),
        NestedScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 0,
                backgroundColor: _isShrink
                    ? Theme.of(context).cardColor
                    : Colors.transparent,
                pinned: true,
                expandedHeight: 290,
                titleSpacing: 10,
                automaticallyImplyLeading: false,
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: SafeArea(
                    child: Stack(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 300,
                            aspectRatio: 18 / 18,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: false,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: false,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) => {
                              setState(
                                () => currentImage = index,
                              )
                            },
                          ),
                          items: [
                            for (var i = 0;
                                i < widget.morrfService.photoUrls.length;
                                i++)
                              i
                          ].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            widget.morrfService.photoUrls[i]),
                                        fit: BoxFit.fitWidth),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: SizedBox(),
        ),
      ],
    ).visible(widget.isVisible);
  }
}
