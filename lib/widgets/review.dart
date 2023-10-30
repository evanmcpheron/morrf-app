import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'constant.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                          width: 2,
                          color: Theme.of(context).colorScheme.primaryColor),
                    ),
                    child: const Center(
                      child: MorrfText(
                        text: '4.9',
                        style: TextStyle(fontSize: 30),
                        size: FontSize.h6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const MorrfText(text: 'Total 22 Reviews', size: FontSize.p),
                ],
              ),
              Positioned(
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, size: 18, color: ratingBarColor),
                        const Icon(Icons.star, size: 18, color: ratingBarColor),
                        const Icon(Icons.star, size: 18, color: ratingBarColor),
                        const Icon(Icons.star, size: 18, color: ratingBarColor),
                        const Icon(Icons.star, size: 18, color: ratingBarColor),
                        LinearPercentIndicator(
                          width: 130,
                          lineHeight: 8.0,
                          percent: 0.8,
                          progressColor:
                              Theme.of(context).colorScheme.primaryColor,
                          backgroundColor: Colors.transparent,
                          barRadius: const Radius.circular(15),
                        ),
                        const SizedBox(
                            width: 30,
                            child: Center(
                                child:
                                    MorrfText(text: '12', size: FontSize.p))),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 18, color: ratingBarColor),
                        const Icon(Icons.star, size: 18, color: ratingBarColor),
                        const Icon(Icons.star, size: 18, color: ratingBarColor),
                        const Icon(Icons.star, size: 18, color: ratingBarColor),
                        LinearPercentIndicator(
                          width: 130,
                          lineHeight: 8.0,
                          percent: 0.4,
                          progressColor:
                              Theme.of(context).colorScheme.primaryColor,
                          backgroundColor: Colors.transparent,
                          barRadius: const Radius.circular(15),
                        ),
                        const SizedBox(
                            width: 30,
                            child: Center(
                                child: MorrfText(text: '5', size: FontSize.p))),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 18, color: ratingBarColor),
                        const Icon(Icons.star, size: 18, color: ratingBarColor),
                        const Icon(Icons.star, size: 18, color: ratingBarColor),
                        LinearPercentIndicator(
                          width: 130,
                          lineHeight: 8.0,
                          percent: 0.3,
                          progressColor:
                              Theme.of(context).colorScheme.primaryColor,
                          backgroundColor: Colors.transparent,
                          barRadius: const Radius.circular(15),
                        ),
                        const SizedBox(
                            width: 30,
                            child: Center(
                                child: MorrfText(text: '4', size: FontSize.p))),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 18, color: ratingBarColor),
                        const Icon(Icons.star, size: 18, color: ratingBarColor),
                        LinearPercentIndicator(
                          width: 130,
                          lineHeight: 8.0,
                          percent: 0.2,
                          progressColor:
                              Theme.of(context).colorScheme.primaryColor,
                          backgroundColor: Colors.transparent,
                          barRadius: const Radius.circular(15),
                        ),
                        const SizedBox(
                            width: 30,
                            child: Center(
                                child: MorrfText(text: '2', size: FontSize.p))),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 18, color: ratingBarColor),
                        LinearPercentIndicator(
                          width: 130,
                          lineHeight: 8.0,
                          percent: 0.1,
                          progressColor:
                              Theme.of(context).colorScheme.primaryColor,
                          backgroundColor: Colors.transparent,
                          barRadius: const Radius.circular(15),
                        ),
                        const SizedBox(
                            width: 30,
                            child: Center(
                                child: MorrfText(text: '0', size: FontSize.p))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ReviewDetails extends StatelessWidget {
  const ReviewDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: context.width(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: kBorderColorTextField),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 40.0,
                width: 40.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/profilepic.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MorrfText(
                    text: 'Abdul Korim',
                    size: FontSize.h6,
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        IconlyBold.star,
                        color: ratingBarColor,
                        size: 18.0,
                      ),
                      SizedBox(width: 5.0),
                      MorrfText(
                        text: '4.9',
                        size: FontSize.p,
                      ),
                      SizedBox(width: 120),
                      MorrfText(
                        text: '5, June 2023',
                        size: FontSize.p,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const MorrfText(
              text:
                  'Nibh nibh quis dolor in. Etiam cras nisi, turpis quisque diam',
              size: FontSize.p),
          const SizedBox(height: 10.0),
          const MorrfText(text: 'Review', size: FontSize.p),
        ],
      ),
    );
  }
}

class ReviewDetails2 extends StatelessWidget {
  const ReviewDetails2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: context.width(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: kBorderColorTextField),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 40.0,
                width: 40.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/profilepic.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MorrfText(
                    text: 'Abdul Korim',
                    size: FontSize.h6,
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        IconlyBold.star,
                        color: ratingBarColor,
                        size: 18.0,
                      ),
                      SizedBox(width: 5.0),
                      MorrfText(
                        text: '4.9',
                        size: FontSize.p,
                      ),
                      SizedBox(width: 120),
                      MorrfText(text: '5, June 2023', size: FontSize.p),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const MorrfText(
            text:
                'Nibh nibh quis dolor in. Etiam cras nisi, turpis quisque diam',
            size: FontSize.p,
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: kBorderColorTextField),
                  image: const DecorationImage(
                      image: AssetImage('images/pic2.png'), fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 10.0),
              Container(
                height: 40,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: kBorderColorTextField),
                  image: const DecorationImage(
                      image: AssetImage('images/pic2.png'), fit: BoxFit.cover),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const MorrfText(text: 'Review', size: FontSize.p),
        ],
      ),
    );
  }
}
