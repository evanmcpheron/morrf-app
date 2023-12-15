import 'package:flutter/material.dart';
import 'package:morrf/core/enums/font_size.dart';

import 'morff_text.dart';

class MorrfRadio extends StatefulWidget {
  final int? initialValue;
  final List<MorrfRadioButton> radios;
  final void Function(int value) onPressed;
  const MorrfRadio(
      {super.key,
      this.initialValue,
      required this.radios,
      required this.onPressed});

  @override
  State<MorrfRadio> createState() => _MorrfRadioState();
}

class _MorrfRadioState extends State<MorrfRadio> {
  late int value = widget.initialValue == null ? 1 : widget.initialValue!;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: buildRadioItem(),
    );
  }

  List<Widget> buildRadioItem() {
    List<Widget> radioItems = [];

    for (int i = 0; i < widget.radios.length; i++) {
      MorrfRadioButton currentRadio = widget.radios[i];
      radioItems.add(GestureDetector(
        onTap: () => {setState(() => value = i), widget.onPressed(i)},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width /
                  (widget.radios.length + 1),
              decoration: BoxDecoration(
                border: Border.all(
                    width: 5,
                    color: value == i
                        ? Theme.of(context).disabledColor
                        : Colors.transparent),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(value == i ? 3 : 8)),
                  child: currentRadio.image),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: MorrfText(size: FontSize.p, text: currentRadio.label),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    width: 3, color: Theme.of(context).disabledColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                width: 10,
                height: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: value == i
                        ? Theme.of(context).colorScheme.inversePrimary
                        : Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const SizedBox(),
                ),
              ),
            )
          ],
        ),
      ));
    }

    return radioItems;
  }
}

class MorrfRadioButton {
  final String label;
  final Widget image;

  const MorrfRadioButton(this.label, this.image);
}
