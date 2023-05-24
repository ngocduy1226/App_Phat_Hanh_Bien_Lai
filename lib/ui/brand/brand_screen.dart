import 'package:flutter/material.dart';

import 'brand_list_tile.dart';
import 'brand_manager.dart';

class BrandScreen extends StatelessWidget {
  static const routeName = '/brand-list';
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandManager = BrandManager();
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 8,
          child: RefreshIndicator(
            child: buildBrandListView(brandManager),
            onRefresh: () async => print('refresh brand'),
          ),
        ),
        Expanded(
          flex: 2,
          child: buildAddButton(context),
        )
      ],
    ));

    // return RefreshIndicator(
    //   child: buildBrandListView(brandManager),
    //   onRefresh: () async => print('refresh brand'),
    //   );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          print('them danh muc');
        },
        icon: const Icon(Icons.add));
  }

  Widget buildBrandListView(BrandManager brandManager) {
    return ListView.builder(
        itemCount: brandManager.itemCount,
        itemBuilder: (ctx, i) => Column(
              children: [
                BrandListTile(brandManager.brandList[i]),
                const Divider(),
              ],
            ));
  }
}
