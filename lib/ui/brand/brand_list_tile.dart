import 'package:flutter/material.dart';

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
      title: Text(
        brand.title,
         style: TextStyle(color: Colors.black)
      ),
      subtitle: Text(
        brand.content
        
        ),
      
     
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
          print('delete brand');
        },
        icon: const Icon(Icons.delete),
        color: Theme.of(context).colorScheme.error
        );
  }
}
