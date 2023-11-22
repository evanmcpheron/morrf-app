import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/models/chat/chat_session_model.dart';
import 'package:morrf/models/chat/message_model.dart';
import "package:uuid/uuid.dart";

class ChatSessionNotifier extends StateNotifier<MorrfChatSession?> {
  var chatSessionRef = FirebaseFirestore.instance.collection("chat-session");
  ChatSessionNotifier() : super(null);

  void getChatSession(String userId, String otherUserId) async {
    var sessionData = await FirebaseFirestore.instance
        .collection('chat-session')
        .where(
          'userId',
          isEqualTo: userId,
        )
        .where('userIds', arrayContains: otherUserId)
        .get();
    if (sessionData.docs.isEmpty) {
      state = null;
    } else {
      state = MorrfChatSession.fromData(sessionData.docs[0].data());
    }
  }

  void createChatSession(
      MorrfChatSession userOne, MorrfChatSession userTwo, String message) {
    chatSessionRef.doc(userOne.id).set(userOne.toJson());

    MorrfMessage morrfMessage = MorrfMessage(
        createdAt: Timestamp.now(),
        id: Uuid().v4(),
        read: false,
        senderId: userOne.userId,
        roomId: userOne.roomId,
        sessionIds: [userOne.id, userTwo.id],
        text: message);
    FirebaseFirestore.instance
        .collection('chat-message')
        .doc(morrfMessage.id)
        .set(morrfMessage.toJson());
  }
}

final chatSessionProvider =
    StateNotifierProvider<ChatSessionNotifier, MorrfChatSession?>((ref) {
  return ChatSessionNotifier();
});
