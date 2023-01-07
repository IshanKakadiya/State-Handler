// ignore_for_file: camel_case_types

import "package:flutter/material.dart";
import 'package:get/get.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            const Text(
              "Get\nOrganic Food",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Find the freshest food and get\nfree delivery in your town",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                Get.toNamed('Produts_Page');
              },
              child: Ink(
                child: Container(
                  height: 50,
                  width: 240,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      color: Color(0xff84801F),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
            Image.asset(
              "assets/buyer.png",
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xffBAB63B),
    );
  }
}
