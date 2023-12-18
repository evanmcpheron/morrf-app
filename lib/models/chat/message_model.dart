import 'package:cloud_firestore/cloud_firestore.dart';

class MorrfMessage {
  String id;
  String senderId;
  List<String> sessionIds;
  String roomId;
  String text;
  bool read;
  Timestamp createdAt;

  MorrfMessage({
    required this.id,
    required this.senderId,
    required this.sessionIds,
    required this.roomId,
    required this.text,
    required this.read,
    required this.createdAt,
  });

  MorrfMessage.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        senderId = data['senderId'],
        sessionIds = data['sessionIds'].cast<String>(),
        roomId = data['roomId'],
        text = data['text'],
        read = data['read'],
        createdAt = data['createdAt'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'sessionId': sessionIds,
      'roomId': roomId,
      'text': text,
      'read': read,
      'createdAt': createdAt,
    };
  }
}
