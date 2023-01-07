// ignore_for_file: file_names, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  // RxList<Product> cartProduts = <Product>[].obs;
  // List cartProduts = <Product>[].obs;

  totalProduct({required List<QueryDocumentSnapshot> cartData}) {
    return cartData.length;
  }

  totalPrice({required List<QueryDocumentSnapshot> cartData}) {
    num price = 0;

    for (var products in cartData) {
      price += (products["price"] * products["count"]);
    }
    update();
    return price;
  }
}
