import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:morrf/screen/client%20screen/client%20home/client_home.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/loading_container.dart';

import 'morff_text.dart';

class MorrfScaffold extends ConsumerStatefulWidget {
  String title;
  Widget body;
  MorrfScaffold({super.key, required this.title, required this.body});

  @override
  ConsumerState<MorrfScaffold> createState() => _MorrfScaffoldState();
}

class _MorrfScaffoldState extends ConsumerState<MorrfScaffold> {
  @override
  Widget build(BuildContext context) {
    return LoadingContainer(
      child: Scaffold(
        appBar: AppBar(
          title: MorrfText(text: widget.title, size: FontSize.h5),
          centerTitle: true,
        ),
        body: Container(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
            width: MediaQuery.of(context).size.width,
            child: widget.body),
      ),
    );
  }
}
