import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:morrf/providers/service/service_provider.dart';
import 'package:morrf/screen/client_screen/client_home/recently_view.dart';
import 'package:morrf/screen/client_screen/client_service_details/tabs/tabs_builder.dart';
import 'package:morrf/screen/global_screen/splash_screen/loading_screen.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/utils/format.dart';
import 'package:morrf/widgets/button_global.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_scaffold.dart';
import 'package:morrf/widgets/review.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
    ref.read(morrfServiceProvider.notifier).getServicesById(widget.serviceId);
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
      body: morrfService == null
          ? MorrfScaffold(title: "", body: Center(child: LoadingPage()))
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
                        child: CarouselSlider.builder(
                          carouselController: _controller,
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
                            onPageChanged: (i, j) {
                              pageController.nextPage(
                                  duration: const Duration(microseconds: 1),
                                  curve: Curves.bounceIn);
                            },
                            scrollDirection: Axis.horizontal,
                          ),
                          itemCount: 10,
                          itemBuilder:
                              (BuildContext context, int index, int realIndex) {
                            return Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Container(
                                  height: 300,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('images/bg2.png'),
                                        fit: BoxFit.fitWidth),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SmoothPageIndicator(
                                      controller: pageController,
                                      count: 3,
                                      effect: JumpingDotEffect(
                                        dotHeight: 6.0,
                                        dotWidth: 6.0,
                                        jumpScale: .7,
                                        verticalOffset: 15,
                                        activeDotColor: kNeutralColor,
                                        dotColor:
                                            kNeutralColor.withOpacity(0.4),
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Container(
                                      height: 20,
                                      width: MediaQuery.of(context).size.width,
                                    )
                                  ],
                                ),
                              ],
                            );
                          },
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
                            Container(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const MorrfText(
                                          text:
                                              'Workout routine for body composition',
                                          maxLines: 2,
                                          size: FontSize.h5,
                                        ),
                                        const SizedBox(height: 5.0),
                                        Row(
                                          children: [
                                            const Icon(
                                              IconlyBold.star,
                                              color: Colors.amber,
                                              size: 18.0,
                                            ),
                                            const SizedBox(width: 5.0),
                                            Row(
                                              children: [
                                                const MorrfText(
                                                  text: '5.0 ',
                                                  size: FontSize.p,
                                                ),
                                                MorrfText(
                                                  text: '(520 reviews)',
                                                  size: FontSize.p,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Icon(
                                              Icons.favorite,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primaryColor,
                                              size: 18.0,
                                            ),
                                            const SizedBox(width: 4.0),
                                            const MorrfText(
                                              text: '807',
                                              maxLines: 1,
                                              size: FontSize.h6,
                                            )
                                          ],
                                        ),
                                        ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          horizontalTitleGap: 10,
                                          leading: const CircleAvatar(
                                            radius: 22.0,
                                            backgroundImage: AssetImage(
                                                'images/profilepic2.png'),
                                          ),
                                          title: const MorrfText(
                                            text: 'William Liamsss',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            size: FontSize.h6,
                                          ),
                                          subtitle: Row(
                                            children: const [
                                              MorrfText(
                                                  text: 'Trainer Level - 1 ',
                                                  size: FontSize.p),
                                              MorrfText(
                                                  text: '(View Profile)',
                                                  isLink: true,
                                                  size: FontSize.lp)
                                            ],
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
                                        const ReadMoreText(
                                          'Lorem ipsum dolor sit amet consectetur. Tortor sapien aliquam amet elit. Quis varius amet grav ida molestie rhoncus. Lorem ipsum dolor sit amet consectetur. Tortor sapien aliquam amet elit. Quis varius amet grav ida molestie rhoncus.',
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
                                          title: morrfService.title,
                                          tabLength:
                                              getTabLength(morrfService.tiers),
                                        ),
                                        const SizedBox(height: 15.0),
                                        const MorrfText(
                                          text: 'Reviews',
                                          maxLines: 1,
                                          size: FontSize.h6,
                                        ),
                                        const SizedBox(height: 15.0),
                                        const Review(),
                                        const SizedBox(height: 15.0),
                                        const ReviewDetails(),
                                        const SizedBox(height: 15.0),
                                        const ReviewDetails2(),
                                        const SizedBox(height: 20.0),
                                        Container(
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              border: Border.all(
                                                  color: kSubTitleColor)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              MorrfText(
                                                text: 'View all reviews',
                                                maxLines: 1,
                                                size: FontSize.p,
                                              ),
                                              Icon(
                                                FeatherIcons.chevronDown,
                                                color: kSubTitleColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0, top: 15),
                                    child: Row(
                                      children: [
                                        const MorrfText(
                                            text: 'Recent Viewed',
                                            size: FontSize.h6),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () => const RecentlyView()
                                              .launch(context),
                                          child: const MorrfText(
                                              text: 'View All',
                                              isLink: true,
                                              size: FontSize.p),
                                        ),
                                      ],
                                    ),
                                  ),
                                  HorizontalList(
                                    physics: const BouncingScrollPhysics(),
                                    padding: const EdgeInsets.only(
                                        left: 15.0, bottom: 15, top: 15),
                                    spacing: 10.0,
                                    itemCount: 10,
                                    itemBuilder: (_, i) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: GestureDetector(
                                          onTap: () => print("clicked"),
                                          // onTap: () => const ClientServiceDetails()
                                          //     .launch(context),
                                          child: Container(
                                            height: 120,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onBackground,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              border: Border.all(
                                                  color: kBorderColorTextField),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  alignment: Alignment.topLeft,
                                                  children: [
                                                    Container(
                                                      height: 120,
                                                      width: 120,
                                                      decoration:
                                                          const BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  8.0),
                                                        ),
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                              'images/shot5.png',
                                                            ),
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isFavorite =
                                                              !isFavorite;
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Container(
                                                          height: 25,
                                                          width: 25,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: isFavorite
                                                              ? const Center(
                                                                  child: Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 16.0,
                                                                  ),
                                                                )
                                                              : const Center(
                                                                  child: Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    color:
                                                                        kNeutralColor,
                                                                    size: 16.0,
                                                                  ),
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      const Flexible(
                                                        child: SizedBox(
                                                          width: 190,
                                                          child: MorrfText(
                                                            text:
                                                                'Workout routine for body composition',
                                                            size: FontSize.lp,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 5.0),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Icon(
                                                            IconlyBold.star,
                                                            color: Colors.amber,
                                                            size: 18.0,
                                                          ),
                                                          const SizedBox(
                                                              width: 2.0),
                                                          const MorrfText(
                                                              text: '5.0',
                                                              size: FontSize.p),
                                                          const SizedBox(
                                                              width: 2.0),
                                                          MorrfText(
                                                            text: '(520)',
                                                            size: FontSize.p,
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary),
                                                          ),
                                                          const SizedBox(
                                                              width: 40),
                                                          Row(
                                                            children: [
                                                              const MorrfText(
                                                                  text:
                                                                      'Price ',
                                                                  size: FontSize
                                                                      .p),
                                                              MorrfText(
                                                                  text:
                                                                      '$currencySign${30}',
                                                                  size: FontSize
                                                                      .p,
                                                                  style: TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .money))
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 5.0),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 32,
                                                            width: 32,
                                                            decoration:
                                                                const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              image: DecorationImage(
                                                                  image: AssetImage(
                                                                      'images/profilepic2.png'),
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 5.0),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: const [
                                                              MorrfText(
                                                                  text:
                                                                      'William Liam',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  size: FontSize
                                                                      .p),
                                                              MorrfText(
                                                                  text:
                                                                      'Trainer Level - 1',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  size: FontSize
                                                                      .p),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
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

  Widget getTab() {
    switch (currentTab) {
      case 0:
      case 1:
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MorrfText(
                text: '$currencySign${60}',
                size: FontSize.p,
                style: TextStyle(color: Theme.of(context).colorScheme.money),
              ),
              const SizedBox(height: 5.0),
              const MorrfText(
                  text: 'I can design the website with 6 pages.',
                  maxLines: 2,
                  size: FontSize.h6),
              const SizedBox(height: 15.0),
              Row(
                children: [
                  Icon(
                    IconlyLight.timeCircle,
                    color: Theme.of(context).colorScheme.primaryColor,
                    size: 18.0,
                  ),
                  const SizedBox(width: 5.0),
                  const MorrfText(
                    text: 'Delivery days',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  const MorrfText(
                    text: '5 Days ',
                    maxLines: 2,
                    size: FontSize.p,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Icon(
                    Icons.loop,
                    color: Theme.of(context).colorScheme.primaryColor,
                    size: 18.0,
                  ),
                  const SizedBox(width: 5.0),
                  const MorrfText(
                    text: 'Revisions',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  const MorrfText(
                    text: 'Unlimited',
                    maxLines: 2,
                    size: FontSize.p,
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              const Divider(
                height: 0,
                thickness: 1.0,
                color: kBorderColorTextField,
              ),
              const SizedBox(height: 15.0),
              Row(
                children: [
                  const MorrfText(
                    text: '3 Page/Screen',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_rounded,
                    color: Theme.of(context).colorScheme.primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  const MorrfText(
                    text: '2 Custom assets',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_rounded,
                    color: Theme.of(context).colorScheme.primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  const MorrfText(
                    text: 'Responsive design',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_rounded,
                    color: Theme.of(context).colorScheme.primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  const MorrfText(
                    text: 'Prototype',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_rounded,
                    color: Theme.of(context).colorScheme.primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  const MorrfText(
                    text: 'Source file',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_rounded,
                    color: Theme.of(context).colorScheme.primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              isSignedIn
                  ? ButtonGlobalWithoutIcon(
                      buttontext: 'Select Offer',
                      buttonDecoration: kButtonDecoration.copyWith(
                        color: Theme.of(context).colorScheme.primaryColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {},
                      buttonTextColor:
                          Theme.of(context).colorScheme.onBackground,
                    )
                  : const SizedBox(),
            ],
          ),
        );
      case 2:
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MorrfText(
                  text: '$currencySign${99}',
                  style: TextStyle(color: Theme.of(context).colorScheme.money),
                  size: FontSize.h6),
              const SizedBox(height: 5.0),
              const MorrfText(
                  text: 'I can design the website with 100 pages.',
                  maxLines: 2,
                  size: FontSize.h6),
              const SizedBox(height: 15.0),
              Row(
                children: [
                  Icon(
                    IconlyLight.timeCircle,
                    color: Theme.of(context).colorScheme.primaryColor,
                    size: 18.0,
                  ),
                  const SizedBox(width: 5.0),
                  const MorrfText(
                    text: 'Delivery days',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  const MorrfText(
                    text: '15 Days ',
                    maxLines: 2,
                    size: FontSize.p,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Icon(
                    Icons.loop,
                    color: Theme.of(context).colorScheme.primaryColor,
                    size: 18.0,
                  ),
                  const SizedBox(width: 5.0),
                  const MorrfText(
                    text: 'Revisions',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  const MorrfText(
                    text: 'Unlimited',
                    maxLines: 2,
                    size: FontSize.p,
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              const Divider(
                height: 0,
                thickness: 1.0,
                color: kBorderColorTextField,
              ),
              const SizedBox(height: 15.0),
              Row(
                children: [
                  const MorrfText(
                    text: '3 Page/Screen',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_rounded,
                    color: Theme.of(context).colorScheme.primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  const MorrfText(
                    text: '2 Custom assets',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_rounded,
                    color: Theme.of(context).colorScheme.primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  const MorrfText(
                    text: 'Responsive design',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_rounded,
                    color: Theme.of(context).colorScheme.primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  const MorrfText(
                    text: 'Prototype',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_rounded,
                    color: Theme.of(context).colorScheme.primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  const MorrfText(
                    text: 'Source file',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_rounded,
                    color: Theme.of(context).colorScheme.primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              isSignedIn
                  ? ButtonGlobalWithoutIcon(
                      buttontext: 'Select Offer',
                      buttonDecoration: kButtonDecoration.copyWith(
                        color: Theme.of(context).colorScheme.primaryColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {},
                      buttonTextColor:
                          Theme.of(context).colorScheme.onBackground,
                    )
                  : const SizedBox(),
            ],
          ),
        );
      default:
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MorrfText(
                text: '$currencySign${30}',
                size: FontSize.h6,
                style: TextStyle(color: Theme.of(context).colorScheme.money),
              ),
              const SizedBox(height: 5.0),
              const MorrfText(
                text: 'I can design the website with 6 pages.',
                maxLines: 2,
                size: FontSize.h6,
              ),
              const SizedBox(height: 15.0),
              Row(
                children: [
                  Icon(
                    IconlyLight.timeCircle,
                    color: Theme.of(context).colorScheme.primaryColor,
                    size: 18.0,
                  ),
                  const SizedBox(width: 5.0),
                  const MorrfText(
                    text: 'Delivery days',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  const MorrfText(
                    text: '5 Days ',
                    maxLines: 2,
                    size: FontSize.p,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Icon(
                    Icons.loop,
                    color: Theme.of(context).colorScheme.primaryColor,
                    size: 18.0,
                  ),
                  const SizedBox(width: 5.0),
                  const MorrfText(
                    text: 'Revisions',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  const MorrfText(
                    text: 'Unlimited',
                    maxLines: 2,
                    size: FontSize.p,
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Divider(
                height: 0,
                thickness: 1.0,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(height: 15.0),
              Row(
                children: [
                  const MorrfText(
                    text: '3 Page/Screen',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_rounded,
                    color: Theme.of(context).colorScheme.primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: const [
                  MorrfText(
                    text: '2 Custom assets',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  Spacer(),
                  Icon(
                    Icons.check_rounded,
                    color: kLightNeutralColor,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  const MorrfText(
                    text: 'Responsive design',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_rounded,
                    color: Theme.of(context).colorScheme.primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: const [
                  MorrfText(
                    text: 'Prototype',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  Spacer(),
                  Icon(
                    Icons.check_rounded,
                    color: kLightNeutralColor,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: [
                  const MorrfText(
                    text: 'Source file',
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.check_rounded,
                    color: Theme.of(context).colorScheme.primaryColor,
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              isSignedIn
                  ? ButtonGlobalWithoutIcon(
                      buttontext: 'Select Offer',
                      buttonDecoration: kButtonDecoration.copyWith(
                        color: Theme.of(context).colorScheme.primaryColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () {},
                      buttonTextColor:
                          Theme.of(context).colorScheme.onBackground,
                    )
                  : const SizedBox(),
            ],
          ),
        );
    }
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
