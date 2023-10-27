class MorrfProductPackage {
  final String id;
  final TierLevel tierLevel;
  final double price;
  final int daysToDeliver;

  MorrfProductPackage(
      {required this.id,
      required this.tierLevel,
      required this.price,
      required this.daysToDeliver});

  MorrfProductPackage.fromDat(Map<String, dynamic> data)
      : id = data['id'],
        tierLevel = data['tierLevel'],
        daysToDeliver = data['daysToDeliver'],
        price = data['price'];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "tierLevel": tierLevel,
      "daysToDeliver": daysToDeliver,
      "price": price,
    };
  }
}

enum TierLevel { basic, standard, premium }
