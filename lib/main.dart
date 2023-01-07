import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_handler/view/screens/cartShoping.dart';
import 'package:state_handler/view/screens/demo_page.dart';
import 'package:state_handler/view/screens/home_page.dart';
import 'package:state_handler/view/screens/produts_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const Home_Page()),
        GetPage(name: "/Produts_Page", page: () => const Produts_Page()),
        GetPage(name: "/Demo_PAge", page: () => const Demo_PAge()),
        GetPage(
            name: "/CartShoping_Page", page: () => const CartShoping_Page()),
      ],
    ),
  );
}
