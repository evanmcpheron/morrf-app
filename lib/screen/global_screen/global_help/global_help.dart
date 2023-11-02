import 'package:flutter/material.dart';
import 'package:morrf/models/service/morrf_faq.dart';
import 'package:morrf/utils/constants/constants.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_button.dart';
import 'package:morrf/widgets/morrf_faq_list.dart';
import 'package:morrf/widgets/morrf_scaffold.dart';

class GlobalHelpAndSupportScreen extends StatefulWidget {
  const GlobalHelpAndSupportScreen({super.key});

  @override
  State<GlobalHelpAndSupportScreen> createState() =>
      _GlobalHelpAndSupportScreenState();
}

class _GlobalHelpAndSupportScreenState
    extends State<GlobalHelpAndSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return MorrfScaffold(
      title: "Help & Support",
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              const MorrfText(
                text: "FAQ",
                size: FontSize.h5,
              ),
              MorrfFaqList(faqList: globalFaq),
            ],
          ),
          Spacer(),
          SafeArea(
            child: MorrfButton(
              onPressed: () => print("ask us a question"),
              fullWidth: true,
              text: "Send us a message",
            ),
          )
        ],
      ),
    );
  }
}
