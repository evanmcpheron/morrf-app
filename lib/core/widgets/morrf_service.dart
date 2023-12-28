import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:morrf/core/constants/constants.dart';
import 'package:morrf/core/enums/font_size.dart';
import 'package:morrf/core/utils/format_date.dart';
import 'package:morrf/core/widgets/morff_text.dart';
import 'package:morrf/models/service/morrf_service.dart';

class MorrfServiceWidget extends StatefulWidget {
  final MorrfService morrfService;
  const MorrfServiceWidget({super.key, required this.morrfService});

  @override
  State<MorrfServiceWidget> createState() => _MorrfServiceWidgetState();
}

class _MorrfServiceWidgetState extends State<MorrfServiceWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              key: UniqueKey(),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                ),
                image: DecorationImage(
                    image: getHeroImage(widget.morrfService),
                    fit: BoxFit.cover),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MorrfText(
                text: widget.morrfService.title,
                size: FontSize.lp,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 25.0),
              Column(
                children: [
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      const MorrfText(text: 'Price ', size: FontSize.p),
                      MorrfText(
                        text:
                            '${Constants.currencySign}${getLowestPrice(widget.morrfService.tiers)}',
                        size: FontSize.p,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  NetworkImage getHeroImage(MorrfService morrfService) {
    return NetworkImage(
      morrfService.heroUrl,
    );
  }
}
