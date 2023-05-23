import 'package:flutter/material.dart';


class ConfigScreen extends StatefulWidget {
  static const routeName = '/config-list';
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Container(
    
    child: Text('Xem danh sach cau hinh.'),
      
    );
  }
}
