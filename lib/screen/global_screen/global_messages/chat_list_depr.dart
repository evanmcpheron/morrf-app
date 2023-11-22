import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:morrf/models/user/morrf_user.dart';
import 'package:morrf/screen/global_screen/global_messages/chat_inbox_depr.dart';
import 'package:morrf/screen/global_screen/splash_screen/loading_screen.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:nb_utils/nb_utils.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController = ScrollController();
  User user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat-room')
              .where(Filter.or(Filter("senderId", isEqualTo: user.uid),
                  Filter("recieverId", isEqualTo: user.uid)))
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, threadSnapshot) {
            if (threadSnapshot.connectionState == ConnectionState.waiting) {
              return LoadingPage();
            }

            if (!threadSnapshot.hasData || threadSnapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text("This is the start of greatness."));
            }

            if (threadSnapshot.hasError) {
              return const Center(child: Text("Something went wrong..."));
            }

            final threads = threadSnapshot.data!.docs;

            return Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: threads.length,
                  itemBuilder: (context, index) {
                    final thread = threads[index].data();
                    final otherUser = user.uid == thread['senderId']
                        ? thread['revieveId']
                        : thread['senderId'];
                    MorrfUser? otherUserData;

                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(otherUser)
                        .get()
                        .then((value) =>
                            otherUserData = MorrfUser.fromData(value.data()!));

                    return Column(
                      children: [
                        const SizedBox(height: 10.0),
                        SettingItemWidget(
                          titleTextStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                          subTitleTextStyle: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          title: "title.validate()",
                          subTitle: "data.subTitle.validate()",
                          leading: Image.network("https://placehold.co/400",
                                  height: 50, width: 50, fit: BoxFit.cover)
                              .cornerRadiusWithClipRRect(25),
                          trailing: Column(
                            children: const [
                              MorrfText(text: '10.00 AM', size: FontSize.p),
                            ],
                          ),
                          onTap: () {
                            ChatInbox(
                                    recipientId: otherUser,
                                    img: "https://placehold.co/400",
                                    name: "data.title.validate()")
                                .launch(context);
                          },
                        ),
                        const Divider(
                          thickness: 1.0,
                          height: 0,
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}
