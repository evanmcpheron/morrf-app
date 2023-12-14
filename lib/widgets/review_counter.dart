import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:morrf/utils/constants/constants.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/morff_text.dart';

class ReviewCounter extends StatelessWidget {
  const ReviewCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          IconlyBold.star,
          color: Colors.amber,
          size: MorrfSize.m.size,
        ),
        const SizedBox(width: 2.0),
        const MorrfText(text: '5.0', size: FontSize.p),
        const SizedBox(width: 2.0),
        MorrfText(
          text: '(520)',
          size: FontSize.p,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }
}
