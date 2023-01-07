// ignore_for_file: camel_case_types, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_handler/controller/productController.dart';
import 'package:state_handler/helper/firebase_helper.dart';

import '../../Globle.dart';

class Produts_Page extends StatefulWidget {
  const Produts_Page({super.key});

  @override
  State<Produts_Page> createState() => _Produts_PageState();
}

class _Produts_PageState extends State<Produts_Page> {
  //
  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 219, 219, 219),
        child: StreamBuilder(
          stream: AddProdutsHelper.addProdutsHelper.fetchAllData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("ERROR : ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              QuerySnapshot? querySnapshot = snapshot.data;

              List<QueryDocumentSnapshot> allDoc = querySnapshot!.docs;

              return StreamBuilder(
                stream: AddProdutsHelper.addProdutsHelper.fetchProductData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("ERROR : ${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    QuerySnapshot? querySnapshotProductData = snapshot.data;

                    List<QueryDocumentSnapshot> productData2 =
                        querySnapshotProductData!.docs;

                    List<QueryDocumentSnapshot> productData = [];

                    for (var product in productData2) {
                      if (Globle.addProductId == product["id"]) {
                        productData.add(product);
                      }
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              height: 260,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color(0xffBAB63B),
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(80),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 60),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.menu,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      const Spacer(),
                                      Image.asset(
                                        'assets/woman.png',
                                        height: 30,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.search),
                                        SizedBox(width: 15),
                                        Text(
                                          "Search foodstuffs",
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              children: [
                                SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: allDoc.map((e) {
                                      return InkWell(
                                        onTap: () {
                                          Globle.addProductId = e["id"];
                                          setState(() {});
                                        },
                                        child: Ink(
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 210, left: 15),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 15),
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  e['image'],
                                                  height: 30,
                                                  width: 30,
                                                ),
                                                const Spacer(),
                                                Text(e["productName"])
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              const Text(
                                "Popular Foodstuffs",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    Navigator.of(context)
                                        .pushNamed('CartShoping_Page');
                                  });
                                },
                                child: Ink(
                                  child: Container(
                                    height: 40,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 5),
                                        const Icon(
                                          size: 25,
                                          Icons.shopping_bag_outlined,
                                          color:
                                              Color.fromARGB(255, 57, 39, 39),
                                        ),
                                        const SizedBox(width: 2),
                                        Container(
                                          height: 33,
                                          width: 33,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffBAB63B),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            Globle.cartListLength.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                        ),
                        Container(
                          height: _height * 0.535,
                          width: _width,
                          padding: const EdgeInsets.all(10),
                          child: GridView.builder(
                            itemCount: productData.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 7,
                              mainAxisSpacing: 7,
                            ),
                            itemBuilder: (context, i) {
                              return Container(
                                padding: const EdgeInsets.only(
                                  top: 5,
                                  bottom: 0,
                                  left: 15,
                                  right: 0,
                                ),
                                height: 185,
                                width: 157,
                                decoration: BoxDecoration(
                                  color: Colors.amber[100],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(productData[i]['image'],
                                            width: 70),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      productData[i]['productName'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          "\$${productData[i]['price']} /-",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () async {
                                            if (productData[i]["isAdd"] ==
                                                false) {
                                              Map<String, dynamic> product = {
                                                // "id": productData[i]["id"],
                                                // "productName": productData[i]
                                                //     // ["productName"],
                                                // "image": productData[i]
                                                //     ["image"],
                                                // "price": productData[i]
                                                //     ["price"],
                                                // "stock": productData[i]
                                                //     ["stock"],
                                                "count": (productData[i]
                                                            ["count"] ==
                                                        0)
                                                    ? 1
                                                    : productData[i]["count"],
                                                "isAdd": true,
                                              };
                                              await AddProdutsHelper
                                                  .addProdutsHelper
                                                  .updateProduct(
                                                      product: product,
                                                      id: productData[i].id);
                                            }
                                          },
                                          child: Ink(
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: const Color(0xffBAB63B),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                "+",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
