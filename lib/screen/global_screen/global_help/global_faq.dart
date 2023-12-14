import 'package:flutter/material.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_scaffold.dart';

class GlobalFaqScreen extends StatefulWidget {
  const GlobalFaqScreen({super.key});

  @override
  State<GlobalFaqScreen> createState() => _GlobalFaqScreenState();
}

class _GlobalFaqScreenState extends State<GlobalFaqScreen> {
  @override
  Widget build(BuildContext context) {
    return MorrfScaffold(
      title: "Help & Support",
      body: const MorrfText(text: "help", size: FontSize.h5),
    );
  }
}
