import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/utils/constants/constants.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/morff_text.dart';

class MorrfTrainerTile extends ConsumerStatefulWidget {
  MorrfTrainerTile({super.key});

  @override
  ConsumerState<MorrfTrainerTile> createState() => _MorrfTrainerTileState();
}

class _MorrfTrainerTileState extends ConsumerState<MorrfTrainerTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MorrfSize.s.size),
      child: Container(
        height: 220,
        width: 156,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MorrfSize.s.size),
          border: Border.all(
              color:
                  Theme.of(context).colorScheme.primaryColor.withOpacity(.5)),
        ),
        child: Column(
          children: [
            Container(
              height: 133,
              width: 156,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(MorrfSize.s.size),
                  topLeft: Radius.circular(MorrfSize.s.size),
                ),
                image: const DecorationImage(
                    image: AssetImage(
                      'images/dev1.png',
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(MorrfSize.s.size),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MorrfText(
                    text: 'William Liam',
                    size: FontSize.h6,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: MorrfSize.s.size),
                  Row(
                    children: [
                      Icon(
                        IconlyBold.star,
                        color: Colors.amber,
                        size: MorrfSize.m.size,
                      ),
                      const SizedBox(width: 2.0),
                      const MorrfText(text: '5.0', size: FontSize.p),
                      SizedBox(width: MorrfSize.xs.size),
                      MorrfText(
                        text: '(520)',
                        size: FontSize.p,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                  SizedBox(height: MorrfSize.s.size),
                  const MorrfText(text: "${5} Services", size: FontSize.p)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
