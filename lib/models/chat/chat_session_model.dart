class MorrfChatSession {
  String id;
  String roomId;
  String userId;
  List<String> userIds;

  MorrfChatSession({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.userIds,
  });

  MorrfChatSession.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        roomId = data['roomId'],
        userId = data['userId'],
        userIds = data['userIds'].cast<String>();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomId': roomId,
      'userId': userId,
      'userIds': userIds,
    };
  }
}
