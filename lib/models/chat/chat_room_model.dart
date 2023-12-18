class MorrfChatRoom {
  String id;
  List<String> userIds;
  String? productId;

  MorrfChatRoom({
    required this.id,
    required this.userIds,
    required this.productId,
  });

  MorrfChatRoom.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        userIds = data['userIds'],
        productId = data['productId'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userIds': userIds,
      'productId': productId,
    };
  }
}
