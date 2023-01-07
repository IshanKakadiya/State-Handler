// ignore_for_file: camel_case_types, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_handler/Globle.dart';
import 'package:state_handler/controller/productController.dart';
import 'package:state_handler/helper/firebase_helper.dart';

class CartShoping_Page extends StatefulWidget {
  const CartShoping_Page({super.key});

  @override
  State<CartShoping_Page> createState() => _CartShoping_PageState();
}

class _CartShoping_PageState extends State<CartShoping_Page> {
  ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: StreamBuilder(
        stream: AddProdutsHelper.addProdutsHelper.fetchProductData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
          } else if (snapshot.hasData) {
            QuerySnapshot? querySnapshotProductData = snapshot.data;

            List<QueryDocumentSnapshot> cartData2 =
                querySnapshotProductData!.docs;

            List<QueryDocumentSnapshot> cartData = [];

            for (var product in cartData2) {
              if (true == product["isAdd"]) {
                cartData.add(product);
              }
            }

            Globle.cartListLength = cartData.length;

            return Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  SizedBox(
                    height: 610,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              splashColor: Colors.grey,
                              child: Ink(
                                child: const Icon(
                                  size: 30,
                                  Icons.backspace,
                                  color: Colors.black,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            const SizedBox(width: 50),
                            const Text(
                              "My Cart",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            const Spacer(),
                            Image.asset(
                              'assets/woman.png',
                              height: 30,
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          height: 532,
                          width: _width,
                          child: ListView.separated(
                            itemCount: cartData.length,
                            separatorBuilder: (context, i) =>
                                const SizedBox(height: 5),
                            itemBuilder: (context, i) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.amber[100],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.asset(
                                      cartData[i]['image'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartData[i]['productName'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 23,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Row(
                                        children: const [
                                          Text(
                                            "India",
                                            style: TextStyle(
                                              color: Colors.black38,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 70,
                                          ),
                                          Text(
                                            "Stock",
                                            style: TextStyle(
                                              color: Colors.black38,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text(
                                            "\$${cartData[i]['price'] * cartData[i]['count']}",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 55,
                                          ),
                                          Text(
                                            cartData[i]['stock'].toString(),
                                            style: const TextStyle(
                                              color: Colors.black38,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              if (cartData[i]["count"] <
                                                  cartData[i]["stock"]) {
                                                int cart =
                                                    cartData[i]["count"] + 1;
                                                Map<String, dynamic> product = {
                                                  "count": cart,
                                                };

                                                await AddProdutsHelper
                                                    .addProdutsHelper
                                                    .updateProduct(
                                                  product: product,
                                                  id: cartData[i].id,
                                                );
                                              }
                                            },
                                            child: Ink(
                                              child: Container(
                                                height: 35,
                                                width: 40,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.horizontal(
                                                    left: Radius.circular(10),
                                                  ),
                                                ),
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  "+",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 35,
                                            width: 50,
                                            color: const Color.fromARGB(
                                                255, 182, 181, 181),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${cartData[i]['count']}",
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              if (cartData[i]["count"] > 1) {
                                                int cart =
                                                    cartData[i]["count"] - 1;
                                                Map<String, dynamic> product = {
                                                  "count": cart,
                                                };

                                                await AddProdutsHelper
                                                    .addProdutsHelper
                                                    .updateProduct(
                                                  product: product,
                                                  id: cartData[i].id,
                                                );
                                              }
                                            },
                                            child: Ink(
                                              child: Container(
                                                height: 35,
                                                width: 40,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.horizontal(
                                                    right: Radius.circular(10),
                                                  ),
                                                ),
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  "-",
                                                  style:
                                                      TextStyle(fontSize: 30),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () {
                                              Map<String, dynamic> product = {
                                                "isAdd": false,
                                              };
                                              AddProdutsHelper.addProdutsHelper
                                                  .updateProduct(
                                                      product: product,
                                                      id: cartData[i].id);
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffBAB63B),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 60),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Total",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            GetBuilder<ProductController>(builder: (_) {
                              return Text(
                                "\$${productController.totalPrice(cartData: cartData)}",
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            })
                          ],
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {});
                          },
                          child: Ink(
                            child: Container(
                              height: 50,
                              width: 140,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Buy Now",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      backgroundColor: const Color.fromARGB(255, 219, 219, 219),
    );
  }
}
