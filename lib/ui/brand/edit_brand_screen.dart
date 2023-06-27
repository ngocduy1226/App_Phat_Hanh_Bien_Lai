import 'package:flutter/material.dart';
import 'package:myshop/SQLDB.dart';
import 'package:myshop/ui/brand/brand_screen.dart';

import '../shared/dialog_utils.dart';

class UpdateBrand extends StatefulWidget {
  final id;
  final content;
  final denominations;
  const UpdateBrand({Key? key, this.id, this.content, this.denominations})
      : super(key: key);

  @override
  State<UpdateBrand> createState() => _UpdateBrandState();
}

class _UpdateBrandState extends State<UpdateBrand> {
  TextEditingController _content = TextEditingController();
  TextEditingController _denominations = TextEditingController();
  SQLdb sqLdb = SQLdb();

  //--------Hàm buttom phát hành-----------------
  Future<void> UpdateBrand() async {
    if (_content.text == null || _content.text == "") {
      showMessage(context, "Lỗi nhập liệu", "Vui lòng nhập nội dung!");
      return;
    }
    if (_denominations.text == null || _denominations.text == "") {
      showMessage(context, "Lỗi nhập liệu", "Vui lòng nhập mệnh giá!");
      return;
    } else {
      int yes = await sqLdb.updateData('''
                      UPDATE "brands" SET
                      content = "${_content.text}",
                      denominations = ${double.parse(_denominations.text)}
                      WHERE id = "${widget.id}"
                    ''');

      if (yes > 0) {
        Navigator.of(context).pop();
      } else {
        showErrorDialog(context, "Tạo danh mục không thành công!");
      }
    }
  }

  @override
  void initState() {
    _content.text = widget.content;
    _denominations.text = widget.denominations.toString();
    //TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh mục - Cập nhật"),
        actions: <Widget>[
          buildBtnAdd(),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              buildUpdateDeno(),
              const SizedBox(
                height: 30,
              ),
              buildUpdateContent(),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBtnAdd() {
    return IconButton(
      onPressed: () async {
        UpdateBrand();
      },
      icon: const Icon(Icons.save, size: 20),
    );
  }

  Widget buildUpdateDeno() {
    return TextField(
      controller: _denominations,
      style: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: const InputDecoration(
        labelText: "Mệnh giá",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }

  Widget buildUpdateContent() {
    return TextField(
      controller: _content,
      style: TextStyle(fontSize: 18, color: Colors.black),
      decoration: InputDecoration(
        labelText: "Nội dung",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }
}
