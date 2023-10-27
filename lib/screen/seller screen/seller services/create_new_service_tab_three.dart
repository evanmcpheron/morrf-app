import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:nb_utils/nb_utils.dart';

class CreateNewServiceTabThree extends StatefulWidget {
  bool isVisible;
  CreateNewServiceTabThree({super.key, required this.isVisible});

  @override
  State<CreateNewServiceTabThree> createState() =>
      _CreateNewServiceTabThreeState();
}

class _CreateNewServiceTabThreeState extends State<CreateNewServiceTabThree> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        const MorrfText(text: 'Image (Up to 3)', size: FontSize.h6),
        const SizedBox(height: 15.0),
        ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: kBorderColorTextField),
                  ),
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        IconlyBold.image,
                        color: kLightNeutralColor,
                        size: 50,
                      ),
                      SizedBox(height: 10.0),
                      MorrfText(text: 'Upload Image', size: FontSize.p),
                    ],
                  ),
                ),
              );
            })
      ],
    ).visible(widget.isVisible);
  }
}
