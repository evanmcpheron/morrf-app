class MorrfUser {
  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  String? gender;
  DateTime? birthday;
  String? photoURL;
  String stripe;
  List<String>? products;
  List<String>? orders;
  String? aboutMe;

  MorrfUser(
      {required this.id,
      required this.firstName,
      this.lastName = "",
      required this.fullName,
      required this.email,
      this.gender,
      this.birthday,
      this.photoURL,
      this.stripe = "",
      this.products,
      this.orders,
      this.aboutMe});

  MorrfUser.fromData(Map<String, dynamic> data)
      : id = data['id'],
        firstName = data['firstName'],
        lastName = data['lastName'],
        fullName = data['fullName'],
        email = data['email'],
        gender = data['gender'],
        birthday = data['birthday'],
        photoURL = data['photoURL'],
        stripe = data['stripe'],
        products = data['products'],
        orders = data['orders'],
        aboutMe = data['aboutMe'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'email': email,
      'gender': gender,
      'birthday': birthday,
      'imageUrl': photoURL,
      'stripe': stripe,
      'orders': orders,
      'products': products,
      'aboutMe': aboutMe
    };
  }

  MorrfUser toMorrf(dynamic user) {
    print(user);
    return MorrfUser(
        id: "123",
        firstName: "firstName",
        fullName: "fullName",
        email: "email");
  }
}
