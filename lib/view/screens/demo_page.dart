import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Demo_PAge extends StatefulWidget {
  const Demo_PAge({super.key});

  @override
  State<Demo_PAge> createState() => _Demo_PAgeState();
}

class _Demo_PAgeState extends State<Demo_PAge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              if (Get.isDarkMode) {
                Get.changeTheme(ThemeData.light());
                print("true");
              } else {
                Get.changeTheme(ThemeData.dark());
                print("false");
              }
            },
          ),
        ],
      ),
      body: Container(),
    );
  }
}
