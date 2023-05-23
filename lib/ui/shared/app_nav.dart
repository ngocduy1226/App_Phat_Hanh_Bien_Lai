import 'package:flutter/material.dart';

//import 'package:provider/provider.dart';

import '../brand/brand_screen.dart';
import '../configuration/config_screen.dart';


//thuc hien dieu huong trong ung dung
class AppNav extends StatelessWidget {
  const AppNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('ShopFruit Xin chào!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Phat hanh'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),


          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Danh muc'),
            onTap: () {
              Navigator.of(context)
                .pushNamed(BrandScreen.routeName);
            
            },
          ),

          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Cau hinh'),
            onTap: () {
              Navigator.of(context)
                .pushNamed(ConfigScreen.routeName);
            
            },
          ),
        ],
      ),
    );
  }
}
