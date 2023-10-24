import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morrf/screen/client%20screen/client%20home/client_home.dart';
import 'package:morrf/utils/enums/font_size.dart';

import 'morff_text.dart';

class MorrfScaffold extends StatefulWidget {
  String title;
  Widget body;
  MorrfScaffold({super.key, required this.title, required this.body});

  @override
  State<MorrfScaffold> createState() => _MorrfScaffoldState();
}

class _MorrfScaffoldState extends State<MorrfScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MorrfText(text: widget.title, size: FontSize.h5),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Container(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: widget.body),
      ),
    );
  }
}
