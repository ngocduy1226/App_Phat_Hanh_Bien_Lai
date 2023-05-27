import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'brand_list_tile.dart';
import 'brand_manager.dart';
import 'edit_brand_screen.dart';

class BrandScreen extends StatelessWidget {
  static const routeName = '/brand-list';
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandManager = BrandManager();
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh mục'),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
     
      body: RefreshIndicator(
        child: buildBrandListView(brandManager),
        onRefresh: () async => print('refresh brand'),
      ),
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            EditBrandScreen.routeName,
          );
        },
        icon: const Icon(Icons.add));
  }

  Widget buildBrandListView(BrandManager brandManager) {
    return Consumer<BrandManager>(builder: (ctx, brandManager, child) {
      return ListView.builder(
          itemCount: brandManager.itemCount,
          itemBuilder: (ctx, i) => Column(
                children: [
                  BrandListTile(brandManager.brandList[i]),
                  const Divider(),
                ],
              ));
    });
  }
}
