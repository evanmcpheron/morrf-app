import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class MorrfProduct {
  final String id, title, imageUrl, productCategoryName;
  final double price, salePrice, rating;
  final bool isOnSale;

  MorrfProduct(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.productCategoryName,
      required this.price,
      required this.salePrice,
      required this.rating,
      required this.isOnSale});
}

int min = 200;
int max = 300;
var rnd = Random();
int randomNumber = min + rnd.nextInt(max - min);

List<MorrfProduct> products = [
  MorrfProduct(
      id: Uuid().v4(),
      title: "Some Service",
      imageUrl: "https://picsum.photos/id/$randomNumber/200/300",
      productCategoryName: "test",
      price: 19.99,
      salePrice: 14.99,
      isOnSale: true,
      rating: 3.5)
];
