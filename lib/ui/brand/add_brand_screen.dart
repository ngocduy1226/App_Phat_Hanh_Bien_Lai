import 'dart:developer' as logDev;
import 'package:flutter/material.dart';


import '../shared/SQLDB.dart';
import '../shared/dialog_utils.dart';


class AddBrand extends StatefulWidget {
  static const routeName = '/add-brand';
  const AddBrand({Key? key}) : super(key: key);

  @override
  State<AddBrand> createState() => _AddBrandState();
}

class _AddBrandState extends State<AddBrand> {
  TextEditingController _content = TextEditingController();
  TextEditingController _denominations = TextEditingController();


  SQLdb sqLdb = SQLdb();

  
  //--------Hàm buttom them danh mục-----------------
  Future<void> addBrand() async {
    if (_content.text == null || _content.text == "") {
      showMessage(context, "Lỗi nhập liệu", "Vui lòng nhập nội dung!");
      return;
    }
    if (_denominations.text == null || _denominations.text == "") {
      showMessage(context, "Lỗi nhập liệu", "Vui lòng nhập mệnh giá!");
      return;
    } else {
      int yes = await sqLdb.insertData(
          "INSERT INTO 'brands' (content,denominations) VALUES ('${_content.text}',${double.parse(_denominations.text)})");

      if (yes > 0) {
        Navigator.of(context).pop();

      } else {
        showErrorDialog(context, "Tạo danh mục không thành công!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh mục - Thêm mới"),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              buildAddDeno(),
              //Text(t!),
              const SizedBox(
                height: 30,
              ),
              buildAddContent(),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      onPressed: () async {
        addBrand();
      },
      icon: Icon(Icons.save, size: 20),
    );
  }

  Widget buildAddDeno() {
    return TextField(
      keyboardType: TextInputType.number,
      controller: _denominations,
      style: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: const InputDecoration(
        labelText: "Nhập mệnh giá",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }

  Widget buildAddContent() {
    return TextField(
      controller: _content,
      autofocus: true,
      style: TextStyle(fontSize: 18, color: Colors.black),
      decoration: const InputDecoration(
        labelText: "Nhập nội dung",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }
}
