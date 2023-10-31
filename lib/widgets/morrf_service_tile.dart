import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:morrf/screen/client_screen/client_service_details/client_service_details.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/utils/format.dart';
import 'package:morrf/widgets/constant.dart';

import 'morff_text.dart';

class MorrfServiceTile extends StatefulWidget {
  MorrfService morrfService;
  MorrfServiceTile({super.key, required this.morrfService});

  @override
  State<MorrfServiceTile> createState() => _MorrfServiceTileState();
}

class _MorrfServiceTileState extends State<MorrfServiceTile> {
  User? user = FirebaseAuth.instance.currentUser;
  late bool isSignedIn = user != null;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () => Get.to(() => ClientServiceDetails(
              serviceId: widget.morrfService.id,
            )),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
                color:
                    Theme.of(context).colorScheme.primaryColor.withOpacity(.5)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.morrfService.heroUrl,
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  isSignedIn
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                shape: BoxShape.circle,
                              ),
                              child: isFavorite
                                  ? const Center(
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 16.0,
                                      ),
                                    )
                                  : const Center(
                                      child: Icon(
                                        Icons.favorite_border,
                                        size: 16.0,
                                      ),
                                    ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: SizedBox(
                        width: (MediaQuery.of(context).size.width - 50) -
                            (MediaQuery.of(context).size.width / 3),
                        child: MorrfText(
                          text: widget.morrfService.title,
                          size: FontSize.lp,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(widget
                                        .morrfService.trainerProfileImage),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MorrfText(
                                    text: widget.morrfService.trainerName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    size: FontSize.p),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width - 50) -
                              (MediaQuery.of(context).size.width / 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    IconlyBold.star,
                                    color: Colors.amber,
                                    size: 18.0,
                                  ),
                                  const SizedBox(width: 2.0),
                                  const MorrfText(
                                      text: '5.0', size: FontSize.p),
                                  const SizedBox(width: 2.0),
                                  MorrfText(
                                    text: '(520)',
                                    size: FontSize.p,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 40),
                              Row(
                                children: [
                                  const MorrfText(
                                      text: 'Price ', size: FontSize.p),
                                  MorrfText(
                                    text:
                                        '$currencySign${getLowestPrice(widget.morrfService.tiers)}',
                                    size: FontSize.p,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .money),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
