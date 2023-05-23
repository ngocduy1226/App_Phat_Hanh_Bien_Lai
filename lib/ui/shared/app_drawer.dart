import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';


import 'app_nav.dart';
import '../reslease/reslease_screen.dart';
import '../brand/brand_screen.dart';
import '../configuration/config_screen.dart';



class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {


  int selectedIndex = 0;
  final List<Widget> pages = [
    const ResLeaseScreen(),
    const BrandScreen (),
    const ConfigScreen(),

  ];

    final List<Widget> titles = [
   const Text('Phat hanh'),
    const Text('Danh mục'),
    const Text('Cau hinh'),
  
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        drawer: const AppNav(),
        appBar: AppBar(
          title: titles[selectedIndex],
          
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: changePage,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Phat hanh',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_rounded),
              label: 'Danh muc',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.android_sharp),
              label: 'Cau hinh',
              backgroundColor: Colors.blue,
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
