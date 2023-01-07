// ignore_for_file: file_names

class Product {
  final int id;
  final String productName;
  final String image;
  final int price;
  final int stock;
  int count;
  bool isAdd;

  Product({
    required this.id,
    required this.productName,
    required this.image,
    required this.price,
    required this.stock,
    required this.count,
    required this.isAdd,
  });
}
