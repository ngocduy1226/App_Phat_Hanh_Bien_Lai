import 'package:flutter/material.dart';
import 'package:myshop/ui/brand/brand_manager.dart';
import 'package:provider/provider.dart';
import '../../models/brand.dart';

class BrandListTile extends StatelessWidget {
  final Brand brand;
  const BrandListTile(
    this.brand, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(brand.title, style: TextStyle(color: Colors.black)),
      subtitle: Text(brand.content),
      trailing: SizedBox(
        width: 100,
        child: Row(children: <Widget>[
          buildEditButton(context),
          buildDeleteButton(context),
        ]),
      ),
    );
  }

  Widget buildEditButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        print('edit brand');
      },
      color: Theme.of(context).primaryColor,
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          // print('delete brand');
          context.read<BrandManager>().deleteBrand(brand.id!);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text(
              'Brand deleted',
              textAlign: TextAlign.center,
              )));
        },
        icon: const Icon(Icons.delete),
        color: Theme.of(context).colorScheme.error);
  }
}
