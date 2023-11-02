import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:morrf/screen/client_screen/client_service_details/client_service_details.dart';
import 'package:morrf/utils/constants/constants.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/utils/format.dart';
import 'package:morrf/widgets/constant.dart';
import 'package:morrf/widgets/review_counter.dart';

import '../morff_text.dart';

class MorrfServiceTile extends StatefulWidget {
  MorrfService morrfService;
  bool fullWidth;
  MorrfServiceTile(
      {super.key, required this.morrfService, this.fullWidth = true});

  @override
  State<MorrfServiceTile> createState() => _MorrfServiceTileState();
}

class _MorrfServiceTileState extends State<MorrfServiceTile> {
  User? user = FirebaseAuth.instance.currentUser;
  late bool isSignedIn = user != null;
  @override
  Widget build(BuildContext context) {
    if (widget.fullWidth) {
      return Padding(
        padding: EdgeInsets.only(bottom: MorrfSize.s.size),
        child: GestureDetector(
          onTap: () => Get.to(() => ClientServiceDetails(
                serviceId: widget.morrfService.id,
              )),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(MorrfSize.s.size),
              border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryColor
                      .withOpacity(.5)),
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
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(MorrfSize.s.size),
                          topLeft: Radius.circular(MorrfSize.s.size),
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
                              padding: EdgeInsets.all(MorrfSize.xs.size),
                              child: Container(
                                height: MorrfSize.xl.size,
                                width: MorrfSize.xl.size,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  shape: BoxShape.circle,
                                ),
                                child: isFavorite
                                    ? Center(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          size: MorrfSize.m.size,
                                        ),
                                      )
                                    : Center(
                                        child: Icon(
                                          Icons.favorite_border,
                                          size: MorrfSize.m.size,
                                        ),
                                      ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(MorrfSize.s.size),
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
                              SizedBox(width: MorrfSize.xs.size),
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
                          SizedBox(height: MorrfSize.xs.size),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width - 50) -
                                (MediaQuery.of(context).size.width / 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ReviewCounter(),
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

    return Padding(
      padding: EdgeInsets.only(bottom: MorrfSize.s.size),
      child: GestureDetector(
        onTap: () => Get.to(() => ClientServiceDetails(
              serviceId: widget.morrfService.id,
            )),
        child: Container(
          height: 140,
          width: MediaQuery.of(context).size.width -
              MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(MorrfSize.s.size),
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
                    height: 140,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(MorrfSize.s.size),
                        topLeft: Radius.circular(MorrfSize.s.size),
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
                            padding: EdgeInsets.all(MorrfSize.xs.size),
                            child: Container(
                              height: MorrfSize.xl.size,
                              width: MorrfSize.xl.size,
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                shape: BoxShape.circle,
                              ),
                              child: isFavorite
                                  ? Center(
                                      child: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: MorrfSize.m.size,
                                      ),
                                    )
                                  : Center(
                                      child: Icon(
                                        Icons.favorite_border,
                                        size: MorrfSize.m.size,
                                      ),
                                    ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(MorrfSize.s.size),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width -
                            MediaQuery.of(context).size.width / 2 -
                            36,
                        child: MorrfText(
                          text: widget.morrfService.title,
                          size: FontSize.lp,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    //Smaller Layout

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
                            SizedBox(width: MorrfSize.xs.size),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MorrfText(
                                    text: widget.morrfService.trainerName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    size: FontSize.p),
                                ReviewCounter(),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: MorrfSize.s.size),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const MorrfText(
                                    text: 'Price ', size: FontSize.p),
                                MorrfText(
                                  text:
                                      '$currencySign${getLowestPrice(widget.morrfService.tiers)}',
                                  size: FontSize.p,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.money),
                                )
                              ],
                            )
                          ],
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
