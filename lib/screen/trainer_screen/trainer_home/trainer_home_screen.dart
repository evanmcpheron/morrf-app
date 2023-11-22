import 'package:flutter/material.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/chart.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/data.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_dropdown.dart';

class TrainerHomeScreen extends StatefulWidget {
  const TrainerHomeScreen({super.key});

  @override
  State<TrainerHomeScreen> createState() => _TrainerHomeScreenState();
}

class _TrainerHomeScreenState extends State<TrainerHomeScreen> {
  List<String> periods = ['This Month', 'Last Month'];
  List<String> periodsReverse = ['Last Month', 'This Month'];
  String selectedPeriod = 'This Month';
  String selectedStatistics = 'Last Month';
  String selectedEarnings = 'Last Month';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryColor
                          .withOpacity(.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const MorrfText(
                          text: 'Performance',
                          size: FontSize.h6,
                        ),
                        const Spacer(),
                        MorrfDrowpdown(
                          label: "Label",
                          compact: true,
                          list: periods,
                          onChange: (value) {
                            setState(() {
                              selectedPeriod = value;
                            });
                          },
                          selected: selectedPeriod,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      children: const [
                        Expanded(
                          flex: 1,
                          child: Summary(
                            title: '80 Orders',
                            subtitle: 'Order Completions',
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          flex: 1,
                          child: Summary2(
                            title1: '5.0/',
                            title2: '5.0',
                            subtitle: 'Positive Ratings',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: const [
                        Expanded(
                          flex: 1,
                          child: Summary(
                            title: '100% On time',
                            subtitle: 'On-Time-Delivery',
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          flex: 1,
                          child: Summary(
                            title: 'Gigs 6 of 7',
                            subtitle: 'Total Gig',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryColor
                          .withOpacity(.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const MorrfText(text: 'Statistics', size: FontSize.h6),
                        const Spacer(),
                        MorrfDrowpdown(
                          label: "Statistics",
                          compact: true,
                          list: periodsReverse,
                          onChange: (value) {
                            setState(() {
                              selectedStatistics = value;
                            });
                          },
                          selected: selectedStatistics,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: RecordStatistics(
                            dataMap: dataMap,
                            colorList: colorList,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: const [
                              ChartLegend(
                                iconColor: Color(0xFF69B22A),
                                title: 'Impressions',
                                value: '5.3K',
                              ),
                              ChartLegend(
                                iconColor: Color(0xFF144BD6),
                                title: 'Interaction',
                                value: '3.5K',
                              ),
                              ChartLegend(
                                iconColor: Color(0xFFFF3B30),
                                title: 'Reached-Out',
                                value: '2.3K',
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryColor
                        .withOpacity(.5),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const MorrfText(text: 'Earnings', size: FontSize.h6),
                        const Spacer(),
                        MorrfDrowpdown(
                          label: "Earnings",
                          compact: true,
                          list: periodsReverse,
                          onChange: (value) {
                            setState(() {
                              selectedEarnings = value;
                            });
                          },
                          selected: selectedEarnings,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      children: const [
                        Expanded(
                          flex: 1,
                          child: Summary(
                            title: '$currencySign${500.00}',
                            subtitle: 'Total Earnings',
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          flex: 1,
                          child: Summary(
                            title: '$currencySign${300.00}',
                            subtitle: 'Withdraw Earnings',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: const [
                        Expanded(
                          flex: 1,
                          child: Summary(
                            title: '$currencySign${300.00}',
                            subtitle: 'Current Balance',
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          flex: 1,
                          child: Summary(
                            title: '$currencySign${300.00}',
                            subtitle: 'Active Orders',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartLegend extends StatelessWidget {
  const ChartLegend({
    Key? key,
    required this.iconColor,
    required this.title,
    required this.value,
  }) : super(key: key);

  final Color iconColor;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.circle,
          size: 16.0,
          color: iconColor,
        ),
        const SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MorrfText(
              text: title,
              size: FontSize.p,
            ),
            const SizedBox(
              height: 5.0,
            ),
            MorrfText(
              text: value,
              size: FontSize.h6,
            ),
          ],
        ),
      ],
    );
  }
}
