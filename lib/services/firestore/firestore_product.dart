import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:morrf/models/product/morrf_product.dart';

class FirestoreProduct {
  final CollectionReference _productCollectionReference =
      FirebaseFirestore.instance.collection("products");
  User? user = FirebaseAuth.instance.currentUser;

  Future createProduct(MorrfProduct product) async {
    try {
      await _productCollectionReference.doc(product.id).set(product.toJson());
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      rethrow;
    }
  }

  Future<List<MorrfProduct?>> getProductsByTrainer(String trainerId) async {
    try {
      List<MorrfProduct> morrfProducts = [];
      await _productCollectionReference
          .where("trainerId", isEqualTo: trainerId)
          .get()
          .then((QuerySnapshot doc) {
        for (var product in doc.docs) {
          morrfProducts.add(
              MorrfProduct.fromData(product.data() as Map<String, dynamic>));
        }
      });
      return morrfProducts;
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      rethrow;
    }
  }
}
