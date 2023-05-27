import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myshop/ui/brand/brand_manager.dart';
import 'package:myshop/ui/brand/edit_brand_screen.dart';
import 'package:myshop/ui/shared/dialog_utils.dart';
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
    var  _amount= double.tryParse(brand.denominations.toString()) ?? 0;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(255, 66, 65, 65),
            style: BorderStyle.solid,
            width: 1.0,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          title: Text(brand.content, style: TextStyle(color: Colors.black)),
          subtitle: Text((NumberFormat('###,###','en_US').format(_amount)).toString()),
          trailing: SizedBox(
            width: 100,
            child: Row(children: <Widget>[
              buildEditButton(context),
              buildDeleteButton(context),
            ]),
          ),
        ),
      ),
    );
  }

  Widget buildEditButton(BuildContext context) {
    // print(brand.id);
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditBrandScreen.routeName,
          arguments: brand.id,
        );
      },
      color: Theme.of(context).primaryColor,
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return IconButton(
        onPressed: () async {
          final shouldDelete = await showConfirmDialog(
              context, "Bạn muốn xóa danh mục đang chọn ?", "Xóa danh mục");

          // print(shouldDelete);
          if (shouldDelete!) {
            context.read<BrandManager>().deleteBrand(brand.id!);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                  content: Text(
                'Danh mục đã được xóa',
                textAlign: TextAlign.center,
              )));
          }
        },
        icon: const Icon(Icons.delete),
        color: Theme.of(context).colorScheme.error);
  }
}
