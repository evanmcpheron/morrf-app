import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/models/user/morrf_user.dart';
import 'package:morrf/providers/user_provider.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/utils/format.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_button.dart';
import 'package:morrf/widgets/morrf_scaffold.dart';

import 'client_edit_profile_details.dart';

class ClientProfileDetails extends ConsumerStatefulWidget {
  const ClientProfileDetails({super.key});

  @override
  ConsumerState<ClientProfileDetails> createState() =>
      _ClientProfileDetailsState();
}

class _ClientProfileDetailsState extends ConsumerState<ClientProfileDetails> {
  User user = FirebaseAuth.instance.currentUser!;

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
    MorrfUser morrfUser = ref.watch(morrfUserProvider);
    String? birthdayString = "---";

    if (morrfUser.birthday != null) {
      var date = DateTime.fromMillisecondsSinceEpoch(
          morrfUser.birthday!.millisecondsSinceEpoch);
      birthdayString = formatDate(date);
    }

    return MorrfScaffold(
        title: "My Profile",
        body: Column(
          children: [
            SingleChildScrollView(
              key: UniqueKey(),
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15.0),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        foregroundImage: NetworkImage(morrfUser.photoURL),
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MorrfText(
                              text: morrfUser.fullName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              size: FontSize.h5),
                          MorrfText(
                              text: morrfUser.email,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              size: FontSize.p),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const MorrfText(
                    text: 'Client Information',
                    size: FontSize.lp,
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: MorrfText(
                          text: 'First Name',
                          size: FontSize.h6,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MorrfText(
                              text: ':',
                              size: FontSize.p,
                            ),
                            const SizedBox(width: 10.0),
                            Flexible(
                              child: MorrfText(
                                text: morrfUser.firstName,
                                size: FontSize.p,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 5.0),
                  const Divider(),
                  const SizedBox(width: 5.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: MorrfText(
                          text: 'Last Name',
                          size: FontSize.h6,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MorrfText(text: ':', size: FontSize.p),
                            const SizedBox(width: 10.0),
                            Flexible(
                              child: MorrfText(
                                text: morrfUser.lastName == ""
                                    ? "---"
                                    : morrfUser.lastName,
                                size: FontSize.p,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 5.0),
                  const Divider(),
                  const SizedBox(width: 5.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: MorrfText(text: 'Full Name', size: FontSize.h6),
                      ),
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MorrfText(text: ':', size: FontSize.p),
                            const SizedBox(width: 10.0),
                            Flexible(
                              child: MorrfText(
                                text: morrfUser.fullName,
                                size: FontSize.p,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 5.0),
                  const Divider(),
                  const SizedBox(width: 5.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: MorrfText(
                          text: 'Email',
                          size: FontSize.h6,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MorrfText(text: ':', size: FontSize.p),
                            const SizedBox(width: 10.0),
                            Flexible(
                              child: MorrfText(
                                text: morrfUser.email,
                                size: FontSize.p,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 5.0),
                  const Divider(),
                  const SizedBox(width: 5.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: MorrfText(
                          text: 'Phone Number',
                          size: FontSize.h6,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MorrfText(text: ':', size: FontSize.p),
                            const SizedBox(width: 10.0),
                            Flexible(
                              child: MorrfText(
                                text: morrfUser.phoneNumber != null
                                    ? morrfUser.phoneNumber!.replaceAllMapped(
                                        RegExp(r'(\d{3})(\d{3})(\d+)'),
                                        (Match m) =>
                                            "(${m[1]}) ${m[2]}-${m[3]}")
                                    : "---",
                                size: FontSize.p,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 5.0),
                  const Divider(),
                  const SizedBox(width: 5.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: MorrfText(
                          text: 'Birthday',
                          size: FontSize.h6,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MorrfText(text: ':', size: FontSize.p),
                            const SizedBox(width: 10.0),
                            Flexible(
                              child: MorrfText(
                                text: birthdayString ?? "---",
                                size: FontSize.p,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 5.0),
                  const Divider(),
                  const SizedBox(width: 5.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: MorrfText(
                          text: 'Gender',
                          size: FontSize.h6,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MorrfText(text: ':', size: FontSize.p),
                            const SizedBox(width: 10.0),
                            Flexible(
                              child: MorrfText(
                                text: morrfUser.gender ?? "---",
                                size: FontSize.p,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 5.0),
                  const Divider(),
                  const SizedBox(width: 5.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: MorrfText(
                          text: 'About Me',
                          size: FontSize.h6,
                        ),
                      ),
                      MorrfText(
                        text: morrfUser.aboutMe ?? "---",
                        size: FontSize.p,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            SafeArea(
              child: MorrfButton(
                fullWidth: true,
                text: 'Edit Profile',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ClientEditProfile()),
                  ).then((value) => setState(() {
                        user = FirebaseAuth.instance.currentUser!;
                      }));
                },
              ),
            ),
          ],
        ));
  }
}
