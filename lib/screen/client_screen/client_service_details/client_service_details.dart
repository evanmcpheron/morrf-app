import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:morrf/providers/service/service_provider.dart';
import 'package:morrf/screen/client_screen/client_service_details/client_order.dart';
import 'package:morrf/screen/client_screen/client_service_details/tabs/tabs_builder.dart';
import 'package:morrf/screen/global_screen/global_messages/chat.dart';
import 'package:morrf/screen/global_screen/global_messages/rooms.dart';
import 'package:morrf/screen/global_screen/splash_screen/loading_screen.dart';
import 'package:morrf/screen/trainer_screen/profile/trainer_profile_details.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/utils/format.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_button.dart';
import 'package:morrf/widgets/morrf_scaffold.dart';
import 'package:morrf/widgets/review.dart';
import 'package:nb_utils/nb_utils.dart';

class ClientServiceDetails extends ConsumerStatefulWidget {
  String serviceId;
  ClientServiceDetails({super.key, required this.serviceId});

  @override
  ConsumerState<ClientServiceDetails> createState() =>
      _ClientServiceDetailsState();
}

class _ClientServiceDetailsState extends ConsumerState<ClientServiceDetails> {
  User? user = FirebaseAuth.instance.currentUser;
  late bool isSignedIn = user != null;
  PageController pageController = PageController(initialPage: 0);
  TabController? tabController;
  int currentTab = 0;
  int currentImage = 0;
  ScrollController? _scrollController;
  bool lastStatus = false;
  double height = 200;

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    pageController.addListener(() {});
    ref.read(morrfServiceProvider.notifier).getServiceById(widget.serviceId);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    MorrfService? morrfService = ref.watch(morrfServiceProvider);
    return Scaffold(
      floatingActionButton: isSignedIn && morrfService != null
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primaryColor,
              onPressed: () {
                Get.to(() => RoomsScreen());
              },
              child: const FaIcon(FontAwesomeIcons.message),
            )
          : null,
      body: morrfService == null
          ? MorrfScaffold(title: "", body: const Center(child: LoadingPage()))
          : NestedScrollView(
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
                    leading: _isShrink
                        ? GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () => {
                                ref.read(morrfServiceProvider.notifier).reset(),
                                Navigator.pop(context)
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).cardColor,
                                ),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                            ),
                          ),
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
                                    i < morrfService.photoUrls.length;
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
                                                morrfService.photoUrls[i]),
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
              body: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: 1,
                      (BuildContext context, int index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MorrfText(
                                          text: morrfService.title,
                                          maxLines: 2,
                                          size: FontSize.h5,
                                        ),
                                        const SizedBox(height: 5.0),
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          horizontalTitleGap: 10,
                                          leading: CircleAvatar(
                                            radius: 22.0,
                                            backgroundImage: NetworkImage(
                                                morrfService
                                                    .trainerProfileImage),
                                          ),
                                          title: MorrfText(
                                            text: morrfService.trainerName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            size: FontSize.h6,
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1.0,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                        const SizedBox(height: 5.0),
                                        const MorrfText(
                                          text: 'Details',
                                          maxLines: 1,
                                          size: FontSize.h6,
                                        ),
                                        const SizedBox(height: 5.0),
                                        ReadMoreText(
                                          morrfService.description,
                                          trimLines: 3,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: '..Read more',
                                          trimExpandedText: '..Read less',
                                        ),
                                        const SizedBox(height: 15.0),
                                        const MorrfText(
                                          text: 'Price',
                                          maxLines: 1,
                                          size: FontSize.h6,
                                        ),
                                        const SizedBox(height: 10.0),
                                        TabsBuilder(
                                          tiers: morrfService.tiers,
                                          image: morrfService.heroUrl,
                                          title: morrfService.title,
                                          tabLength:
                                              getTabLength(morrfService.tiers),
                                        ),
                                        const SizedBox(height: 15.0),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  List<Widget> getTabList(Map<String, Tier> tiers) {
    List<Widget> tabList = [];
    if (tiers['basic']!.isVisible) {
      tabList.add(const Tab(text: "Basic"));
    }
    if (tiers['standard']!.isVisible) {
      tabList.add(const Tab(text: "Standard"));
    }
    if (tiers['premium']!.isVisible) {
      tabList.add(const Tab(text: "Premium"));
    }

    return tabList;
  }
}
