import 'package:flutter/material.dart';
import 'package:myshop/ui/brand/add_brand_screen.dart';
import 'package:myshop/ui/brand/brand_screen.dart';
import 'package:myshop/ui/reslease/reslease_screen.dart';
import 'package:myshop/ui/shared/app_drawer.dart';

import 'ui/configuration/add_config_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phát hành',
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Colors.blue,
        ),
      ),
       home: const AppDrawer(),
     
      routes: {
        "addBrand": (context) => const AddBrand(),
        "addConfig": (context) => const AddConfig(),
        "appDrawer": (context) => const AppDrawer(),
      },
    );
  }
}
