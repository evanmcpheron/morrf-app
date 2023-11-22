import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/models/chat/chat_session_model.dart';
import 'package:morrf/models/chat/message_model.dart';
import 'package:morrf/models/user/morrf_user.dart';
import 'package:morrf/providers/chat/chat_room_provider.dart';
import 'package:morrf/providers/chat/chat_session_provider.dart';
import 'package:morrf/providers/user_provider.dart';
import 'package:morrf/screen/global_screen/global_messages/message_bubbles.dart';
import 'package:morrf/screen/global_screen/splash_screen/loading_screen.dart';
import 'package:morrf/screen/trainer_screen/trainer_popUp/trainer_popup.dart';
import 'package:morrf/utils/constants/special_color.dart';
import 'package:morrf/utils/enums/font_size.dart';
import 'package:morrf/widgets/morff_text.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uuid/uuid.dart';

class ChatInbox extends ConsumerStatefulWidget {
  final String img;
  final String name;
  final String recipientId;

  const ChatInbox(
      {super.key,
      required this.img,
      required this.name,
      required this.recipientId});

  @override
  ConsumerState<ChatInbox> createState() => _ChatInboxState();
}

class _ChatInboxState extends ConsumerState<ChatInbox> {
  User user = FirebaseAuth.instance.currentUser!;

  //__________Blocking_reason_popup________________________________________________
  void showBlockPopUp() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const BlockingReasonPopUp(),
            );
          },
        );
      },
    );
  }

  //__________Blocking_reason_popup________________________________________________
  void showAddFilePopUp() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const ImportDocumentPopUp(),
            );
          },
        );
      },
    );
  }

  ScrollController scrollController = ScrollController();

  TextEditingController messageController = TextEditingController();

  FocusNode msgFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    ref
        .read(chatSessionProvider.notifier)
        .getChatSession(user.uid, widget.recipientId);
  }

  @override
  Widget build(BuildContext context) {
    List<MorrfMessage?> messages = [];

    MorrfChatSession? sessionData = ref.watch(chatSessionProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leadingWidth: 24,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(radius: 20, backgroundImage: NetworkImage(widget.img)),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MorrfText(text: widget.name, size: FontSize.h6),
                // const MorrfText(text: 'Online', size: FontSize.p),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryColor
                      .withOpacity(.5),
                ),
              ),
              child: PopupMenuButton(
                itemBuilder: (BuildContext bc) => [
                  PopupMenuItem(
                      child: const MorrfText(text: 'Block', size: FontSize.p)
                          .onTap(() => showBlockPopUp())),
                  const PopupMenuItem(
                    child: MorrfText(
                      text: 'Report',
                      size: FontSize.p,
                    ),
                  ),
                ],
                onSelected: (value) {
                  Navigator.pushNamed(context, '$value');
                },
                child: const Icon(
                  FeatherIcons.moreVertical,
                ),
              ),
            ),
          )
        ],
        elevation: 0,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat-message')
              .where('sessionId', arrayContains: sessionData?.id)
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, chatSnapshot) {
            switch (chatSnapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return LoadingPage();
              case ConnectionState.done:
              case ConnectionState.active:
                if (chatSnapshot.hasData) {
                  messages = chatSnapshot.data!.docs
                      .map((e) => MorrfMessage(
                          id: e['id'],
                          senderId: e['senderId'],
                          sessionIds: [],
                          roomId: "",
                          text: e['text'],
                          read: e['read'],
                          createdAt: e['createdAt']))
                      .toList();
                }
                if (messages.isNotEmpty) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 8),
                            // const MorrfText(text: '9:41 AM', size: FontSize.lp),
                            const SizedBox(height: 8),
                            ListView.builder(
                              padding: const EdgeInsets.all(16.0),
                              controller: scrollController,
                              scrollDirection: Axis.vertical,
                              reverse: true,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final MorrfMessage chatMessage =
                                    messages[index]!;

                                final MorrfMessage? nextChatMessage =
                                    index + 1 < messages.length
                                        ? messages[index + 1]
                                        : null;
                                final currentMessageUserId =
                                    chatMessage.senderId;
                                final nextMessageUserId =
                                    nextChatMessage?.senderId;
                                final nextUserIsSame =
                                    nextMessageUserId == currentMessageUserId;

                                if (nextUserIsSame) {
                                  return MessageBubble.next(
                                      message: chatMessage.text,
                                      isMe: user.uid == currentMessageUserId);
                                } else {
                                  return MessageBubble.first(
                                      userImage: "https://placehold.co/400x400",
                                      username: chatMessage.senderId,
                                      message: chatMessage.text,
                                      isMe: user.uid == currentMessageUserId);
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ).paddingTop(8.0);
                } else {
                  return const Center(
                      child: Text("This is the start of greatness."));
                }
              default:
                return const Center(
                  child: Text("Somethign went wrong"),
                );
            }
          }),
      bottomNavigationBar: Container(
        padding: MediaQuery.of(context).viewInsets,
        decoration: boxDecorationWithRoundedCorners(
          backgroundColor: Theme.of(context).cardColor,
          borderRadius: radius(0.0),
          border: Border.all(color: Theme.of(context).cardColor),
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showAddFilePopUp();
                    });
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryColor
                                  .withOpacity(.5)),
                          color: Theme.of(context).cardColor),
                      child: Icon(
                        FeatherIcons.link,
                        color: Theme.of(context).colorScheme.onBackground,
                      )),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: AppTextField(
                    controller: messageController,
                    textFieldType: TextFieldType.OTHER,
                    focus: msgFocusNode,
                    autoFocus: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .primaryColor
                              .withOpacity(.5),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                        borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .primaryColor
                              .withOpacity(.5),
                        ),
                      ),
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      hintText: 'Message...',
                      suffixIcon: Icon(Icons.send_outlined,
                              size: 24,
                              color: Theme.of(context).colorScheme.primaryColor)
                          .paddingAll(4.0)
                          .onTap(
                        () {
                          addMessage();
                          if (messageController.text.isNotEmpty) {
                            messageController.clear();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addMessage() {
    hideKeyboard(context);
    setState(
      () {
        final enteredMessage = messageController.text;
        print("Start new session");
        ref.read(chatRoomProvider.notifier).getExistingChatRoom(
            widget.recipientId,
            enteredMessage,
            ref.read(chatSessionProvider.notifier));

        // if (mounted) scrollController.animToTop();
        FocusScope.of(context).requestFocus(msgFocusNode);
        setState(() {});
      },
    );
  }
}
