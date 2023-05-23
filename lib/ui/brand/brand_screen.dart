import 'package:flutter/material.dart';


class BrandScreen extends StatefulWidget {
  static const routeName = '/brand-list';
  const BrandScreen({super.key});

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  
   
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Xem danh sach danh muc.'),
    );
  }
}
