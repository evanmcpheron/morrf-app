import 'package:flutter/material.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/models/morrf_faq.dart';
import 'package:morrf/core/widgets/morff_text.dart';

class MorrfFaqList extends StatefulWidget {
  List<MorrfFaq?> faqList;
  MorrfFaqList({super.key, required this.faqList});

  @override
  State<MorrfFaqList> createState() => _MorrfFaqListState();
}

class _MorrfFaqListState extends State<MorrfFaqList> {
  @override
  Widget build(BuildContext context) {
    return Column(children: buildFaqTile());
  }

  List<Widget> buildFaqTile() {
    List<Widget> faqEntries = [];

    if (widget.faqList.isEmpty) {
      return [
        const MorrfText(
          text: "You haven't listed an FAQ yet",
          size: FontSize.h4,
          textAlign: TextAlign.center,
        )
      ];
    }

    for (MorrfFaq? faq in widget.faqList) {
      String question = faq!.question;
      String answer = faq.answer;

      faqEntries.add(
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: Column(
            children: [
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                iconColor: Colors.red,
                collapsedIconColor: Colors.red,
                title: MorrfText(
                  text: question,
                  size: FontSize.p,
                ),
                children: [
                  MorrfText(
                    text: answer,
                    size: FontSize.p,
                  ),
                ],
              ),
              const Divider(
                height: 1,
              )
            ],
          ),
        ),
      );
    }

    return faqEntries;
  }
}
