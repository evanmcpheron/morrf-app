class MorrfRating {
  final String id;
  final String userName;
  final String description;
  final int rating;

  MorrfRating(
      {required this.id,
      required this.userName,
      required this.description,
      required this.rating});

  MorrfRating.fromDat(Map<String, dynamic> data)
      : id = data['id'],
        userName = data['userName'],
        description = data['description'],
        rating = data['rating'];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userName": userName,
      "description": description,
      "rating": rating
    };
  }
}
