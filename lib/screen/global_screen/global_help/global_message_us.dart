import 'package:flutter/material.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_scaffold.dart';

class GlobalMessageUsScreen extends StatefulWidget {
  const GlobalMessageUsScreen({super.key});

  @override
  State<GlobalMessageUsScreen> createState() => _GlobalMessageUsScreenState();
}

class _GlobalMessageUsScreenState extends State<GlobalMessageUsScreen> {
  @override
  Widget build(BuildContext context) {
    return MorrfScaffold(
      title: "Help & Support",
      body: const MorrfText(text: "help", size: FontSize.h5),
    );
  }
}
