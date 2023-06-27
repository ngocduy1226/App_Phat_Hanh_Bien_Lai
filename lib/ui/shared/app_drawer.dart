import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

import '../brand/brand_screen.dart';
import '../reslease/reslease_screen.dart';
import '../brand/brand_screen.dart';
import '../configuration/config_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});
  static const routeName = '/app-drawer';
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int selectedIndex = 0;
  final List<Widget> pages = [
    const ResLeaseScreen(),
  
    const ConfigScreen(),
    const BrandScreen(),
  ];

  final List<Widget> titles = [
    const Text('Phát hành'),
    const Text('Cấu hình'),
    const Text('Danh mục'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // drawer: const AppNav(),
        // appBar: AppBar(
        //   title: titles[selectedIndex],
        // ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: changePage,
          backgroundColor: Colors.blue,
          unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.publish),
              label: 'Phát hành',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Cấu hình',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_rounded),
              label: 'Danh mục',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.black,
        ),
        body: pages[selectedIndex],
      ),
    );
  }

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
