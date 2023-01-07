import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:state_handler/model/ProductModel.dart';

class AddProdutsHelper {
  AddProdutsHelper._();
  static final AddProdutsHelper addProdutsHelper = AddProdutsHelper._();

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  insertData({
    required int id,
    required String productName,
    required String image,
    // required int price,
    // required int stock,
    // int count = 0,
    // bool isAdd = false,
  }) {
    Map<String, dynamic> product = {
      "id": id,
      "productName": productName,
      "image": image,
      // "price": price,
      // "stock": stock,
      // "count": count,
      // "isAdd": isAdd,
    };

    firestore.collection("TopDisplayProducts").add(product);
  }

  // Fetch All Data
  Stream<QuerySnapshot> fetchAllData() {
    return firestore.collection("TopDisplayProducts").snapshots();
  }

  Stream<QuerySnapshot> fetchProductData() {
    return firestore.collection("Products").snapshots();
  }

  updateProduct(
      {required Map<String, dynamic> product, required String id}) async {
    await firestore.collection("Products").doc(id).update(product);
  }
}
