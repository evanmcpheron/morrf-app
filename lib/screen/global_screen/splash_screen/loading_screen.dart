import 'package:flutter/material.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/utils/enums/font_size.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 145,
          width: 120,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'images/grey-logo.png',
                ),
                fit: BoxFit.cover),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: MorrfText(size: FontSize.p, text: "LOADING..."),
        ),
      ],
    ));
  }
}
