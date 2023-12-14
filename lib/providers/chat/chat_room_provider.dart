import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/models/chat/chat_room_model.dart';
import 'package:morrf/models/chat/chat_session_model.dart';
import 'package:morrf/providers/chat/chat_session_provider.dart';
import 'package:uuid/uuid.dart';

class ChatRoomNotifier extends StateNotifier<MorrfChatRoom?> {
  User user = FirebaseAuth.instance.currentUser!;
  var chatRoomRef = FirebaseFirestore.instance.collection("chat-room");
  ChatRoomNotifier() : super(null);

  void getExistingChatRoom(
      String trainerId, String message, ChatSessionNotifier ref) async {
    // keep state set to null if it doesn't exist
    var chatRoom = await chatRoomRef.where(
      'userIds',
      isEqualTo: [user.uid, trainerId],
    ).get();

    if (chatRoom.docs.isNotEmpty) {
      state = MorrfChatRoom.fromData(chatRoom.docs.first.data());
      return;
    }
    createNewChatRoom(trainerId, message, ref);
    return;
  }

  void createNewChatRoom(String trainerId, String message,
      ChatSessionNotifier chatSessionRef) async {
    String roomId = const Uuid().v4();
    String userSessionId = const Uuid().v4();
    String trainerSessionId = const Uuid().v4();

    MorrfChatRoom morrfChatRoom = MorrfChatRoom(
        id: roomId, userIds: [user.uid, trainerId], productId: null);
    await chatRoomRef.doc(roomId).set(morrfChatRoom.toJson());
    MorrfChatSession morrfChatSession = MorrfChatSession(
        id: userSessionId,
        roomId: roomId,
        userId: user.uid,
        userIds: [user.uid, trainerId]);
    MorrfChatSession morrfTrainerChatSession = MorrfChatSession(
        id: trainerSessionId,
        roomId: roomId,
        userId: trainerId,
        userIds: [user.uid, trainerId]);

    state = morrfChatRoom;
    chatSessionRef.createChatSession(
        morrfChatSession, morrfTrainerChatSession, message);
    chatSessionRef.createChatSession(
        morrfTrainerChatSession, morrfChatSession, message);
  }
}

final chatRoomProvider =
    StateNotifierProvider<ChatRoomNotifier, MorrfChatRoom?>((ref) {
  return ChatRoomNotifier();
});
