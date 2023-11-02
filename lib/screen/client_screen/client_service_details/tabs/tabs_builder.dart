import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_button.dart';

class TabsBuilder extends StatefulWidget {
  Map<String, Tier> tiers;
  int tabLength;
  String title;
  TabsBuilder(
      {super.key,
      required this.tiers,
      required this.title,
      this.tabLength = 3});

  @override
  State<TabsBuilder> createState() => _TabsBuilderState();
}

class _TabsBuilderState extends State<TabsBuilder>
    with TickerProviderStateMixin {
  User? user = FirebaseAuth.instance.currentUser;
  late bool isSignedIn = user != null;
  TabController? tabController;
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.tabLength, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    getCorrectTabTemplate();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: Theme.of(context).colorScheme.onBackground, width: .5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
              ),
              color: Theme.of(context).colorScheme.primaryColor,
            ),
            onTap: (value) {
              setState(() {
                currentTab = value;
              });
            },
            controller: tabController,
            labelColor: Theme.of(context).colorScheme.onBackground,
            tabs: getTabList(widget.tiers),
          ),
          Divider(
            height: 0,
            thickness: 1.0,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          SizedBox(
            child: getCorrectTabTemplate(),
          )
        ],
      ),
    );
  }

  Widget tabTemplate(Tier tierData) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MorrfText(
            text: '$currencySign${tierData.price}',
            size: FontSize.h6,
            style: TextStyle(color: Theme.of(context).colorScheme.money),
          ),
          const SizedBox(height: 5.0),
          MorrfText(
            text: tierData.title,
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
              MorrfText(
                text: '${tierData.deliveryTime} Days ',
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
              MorrfText(
                text: tierData.revisions.toString(),
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
          ListView.builder(
            itemCount: tierData.options.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 10.0),
            itemBuilder: (_, i) {
              Option currentOption = tierData.options[i]!;
              return Row(
                children: [
                  MorrfText(
                    text: currentOption.title,
                    maxLines: 1,
                    size: FontSize.p,
                  ),
                  const Spacer(),
                  currentOption.isSelected
                      ? FaIcon(
                          FontAwesomeIcons.check,
                          color: Theme.of(context).colorScheme.primaryColor,
                        )
                      : const FaIcon(FontAwesomeIcons.minus),
                ],
              );
            },
          ),
          const SizedBox(height: 5.0),
          const SizedBox(height: 10.0),
          isSignedIn
              ? MorrfButton(
                  text: "Select Offer",
                  onPressed: () {},
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  List<Widget> getTabList(Map<String, Tier> tiers) {
    List<Widget> tabList = [];

    widget.tiers.forEach(
      (key, value) => {
        if (value.isVisible)
          {
            tabList.add(
              Tab(text: key.capitalize),
            ),
          },
      },
    );

    return tabList;
  }

  Widget getCorrectTabTemplate() {
    List<Widget> tabList = [];

    widget.tiers.forEach(
      (key, value) => {
        if (value.isVisible)
          {
            tabList.add(
              tabTemplate(value),
            ),
          },
      },
    );
    if (tabList.isEmpty) return const SizedBox();
    return tabList[currentTab];
  }
}
