import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morrf/screen/splash%20screen/loading_screen.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:morrf/widgets/morrf_button.dart';
import 'package:morrf/widgets/morrf_scaffold.dart';

import 'client_edit_profile_details.dart';

class ClientProfileDetails extends StatefulWidget {
  const ClientProfileDetails({Key? key}) : super(key: key);

  @override
  State<ClientProfileDetails> createState() => _ClientProfileDetailsState();
}

class _ClientProfileDetailsState extends State<ClientProfileDetails> {
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
    User user = FirebaseAuth.instance.currentUser!;
    return MorrfScaffold(
      title: "My Profile",
      body: FutureBuilder(
        future:
            FirebaseFirestore.instance.collection("users").doc(user!.uid).get(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            var morrfUser = snapshot.data.data();
            String? gender = morrfUser['gender'];
            String? aboutMe = morrfUser['aboutMe'];
            String? phoneNumber = morrfUser['phoneNumber'];
            String? birthday = morrfUser['birthday'];
            return Column(
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
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(user!.photoURL!),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MorrfText(
                                  text: user!.displayName!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  size: FontSize.h5),
                              MorrfText(
                                  text: user!.email!,
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
                                    text: user!.displayName!.split(" ")[0],
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
                                    text: user!.displayName!.split(" ")[1] == ""
                                        ? "---"
                                        : user!.displayName!.split(" ")[1],
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
                            child:
                                MorrfText(text: 'Full Name', size: FontSize.h6),
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
                                    text: user!.displayName!,
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
                                    text: user!.email!,
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
                                    text: phoneNumber != null
                                        ? phoneNumber.replaceAllMapped(
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
                                    text: birthday != null ? birthday : "---",
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
                                    text: gender ?? "---",
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
                            text: aboutMe ?? "---",
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
                    child:
                        const MorrfText(text: 'Edit Profile', size: FontSize.p),
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
            );
          } else {
            return LoadingPage();
          }
        },
      ),
    );
  }
}
