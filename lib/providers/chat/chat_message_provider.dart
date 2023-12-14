import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morrf/models/chat/message_model.dart';

class ChatMessageNotifier extends StateNotifier<MorrfMessage?> {
  ChatMessageNotifier() : super(null);
}

final chatSessionProvider =
    StateNotifierProvider<ChatMessageNotifier, MorrfMessage?>((ref) {
  return ChatMessageNotifier();
});
