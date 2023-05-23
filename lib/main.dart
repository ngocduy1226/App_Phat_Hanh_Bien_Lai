import 'package:flutter/material.dart';
import 'ui/screen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary:Colors.deepOrange,
        ),
      ),
      home: const AppDrawer(),
      routes: {
        BrandScreen.routeName:
           (ctx) => const BrandScreen(),
        ConfigScreen.routeName:
           (ctx) => const ConfigScreen(),
        ResLeaseScreen.routeName:
           (ctx) => const ResLeaseScreen(),    
      },

    );
  }
}
