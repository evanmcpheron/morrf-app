import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/core/enums/font_size.dart';

import 'morff_text.dart';

class MorrfScaffold extends ConsumerStatefulWidget {
  String title;
  Widget? leading;
  void Function()? leadingPressed;
  Widget? trailing;
  void Function()? trailingPressed;
  Widget body;
  MorrfScaffold(
      {super.key,
      required this.title,
      required this.body,
      this.leading,
      this.trailing,
      this.trailingPressed,
      this.leadingPressed});

  @override
  ConsumerState<MorrfScaffold> createState() => _MorrfScaffoldState();
}

class _MorrfScaffoldState extends ConsumerState<MorrfScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.leading != null || widget.trailing != null
            ? ListTile(
                contentPadding: const EdgeInsets.only(bottom: 10),
                leading: widget.leading != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: GestureDetector(
                          onTap: () => widget.leadingPressed != null
                              ? widget.leadingPressed!()
                              : print("Nothing to see here"),
                          child: SizedBox(
                            height: 44,
                            width: 44,
                            child: widget.leading,
                          ),
                        ),
                      )
                    : const SizedBox(),
                title: Center(
                    child: MorrfText(text: widget.title, size: FontSize.h5)),
                trailing: widget.trailing != null
                    ? GestureDetector(
                        onTap: () => widget.trailingPressed != null
                            ? widget.trailingPressed!()
                            : print("Nothing to see here"),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(),
                          ),
                          child: widget.trailing,
                        ),
                      )
                    : const SizedBox(),
              )
            : MorrfText(text: widget.title, size: FontSize.h5),
      ),
      body: Container(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
          width: MediaQuery.of(context).size.width,
          child: widget.body),
    );
  }
}
