

class MorrfBillingDetails {
  String email;
  String phone;
  String name;
  MorrfAddress address;

  MorrfBillingDetails({
    required this.email,
    required this.phone,
    required this.name,
    required this.address,
  });

  factory MorrfBillingDetails.fromJson(Map<String, dynamic> json) {
    return MorrfBillingDetails(
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      address: MorrfAddress.fromJson(json['address']),
    );
  }
}

class MorrfAddress {
  String postalCode;
  String state;
  String country;
  String line2;
  String city;
  String line1;

  MorrfAddress({
    required this.postalCode,
    required this.state,
    required this.country,
    required this.line2,
    required this.city,
    required this.line1,
  });

  factory MorrfAddress.fromJson(Map<String, dynamic> json) {
    return MorrfAddress(
      postalCode: json['postal_code'],
      state: json['state'],
      country: json['country'],
      line2: json['line2'],
      city: json['city'],
      line1: json['line1'],
    );
  }
}
