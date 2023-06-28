import 'dart:developer' as logDev;
import 'package:flutter/material.dart';

import '../shared/SQLDB.dart';
import '../shared/dialog_utils.dart';

// import '../share/app_drawer.dart';

class AddConfig extends StatefulWidget {
  static const routeName = '/add-config';
  const AddConfig({Key? key}) : super(key: key);

  @override
  State<AddConfig> createState() => _AddConfigState();
}

class _AddConfigState extends State<AddConfig> {
  TextEditingController _urlservice = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _acacount = TextEditingController();
  TextEditingController _acpass = TextEditingController();
  TextEditingController _pattern = TextEditingController();
  TextEditingController _serial = TextEditingController();


  SQLdb sqLdb = SQLdb();
 

  //--------Hàm buttom cấu hình-----------------
  Future<void> addConfig() async {
     if (_urlservice.text == null || _urlservice.text == "") {
      showMessage(context, "Lỗi nhập liệu", "Vui lòng nhập URL Service!");
      return;
    }
    if (_username.text == null || _username.text == "") {
      showMessage(context, "Lỗi nhập liệu", "Vui lòng nhập họ tên!");
      return;
    }
    if (_pass.text == null || _pass.text == "") {
      showMessage(context, "Lỗi nhập liệu", "Vui lòng nhập mật khẩu!");
      return;
    }
   
    if (_acacount.text == null || _acacount.text == "") {
      showMessage(context, "Lỗi nhập liệu", "Vui lòng nhập tên tài khoản!");
      return;
    }
    if (_acpass.text == null || _acpass.text == "") {
      showMessage(
          context, "Lỗi nhập liệu", "Vui lòng nhập mật khẩu của tài khoản!");
      return;
    }
    if (_pattern.text == null || _pattern.text == "") {
      showMessage(context, "Lỗi nhập liệu", "Vui lòng nhập pattern!");
      return;
    }
    if (_serial.text == null || _serial.text == "") {
      showMessage(context, "Lỗi nhập liệu", "Vui lòng nhập số serial!");
      return;
    } else {
      int yes = await sqLdb.insertData(
          "INSERT INTO 'configs' (urlservice,username,pass,acacount,acpass,pattern,serial) VALUES ('${_urlservice.text}','${_username.text}','${_pass.text}','${_acacount.text}','${_acpass.text}','${_pattern.text}','${_serial.text}' )");

      if (yes > 0) {
        Navigator.of(context).pop();

      } else {
        showErrorDialog(context, "Tạo cấu hình không thành công!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cấu hình - Thêm mới"),
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
              buildAddSer(),
              //Text(t!),
              const SizedBox(
                height: 30,
              ),
              buildAddName(),
              const SizedBox(
                height: 30,
              ),
              buildAddPass(),
              const SizedBox(
                height: 30,
              ),
              buildAddAcc(),
              const SizedBox(
                height: 30,
              ),
              buildAddAccPass(),
              const SizedBox(
                height: 30,
              ),
              buildAddPattern(),
              const SizedBox(
                height: 30,
              ),
              buildAddSerial(),
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
        addConfig();
      },
      icon: Icon(Icons.save, size: 20),
    );
  }

  Widget buildAddSer() {
    return TextField(
      controller: _urlservice,
      style: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: const InputDecoration(
        labelText: "Nhập urlservice",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }

  Widget buildAddName() {
    return TextField(
      controller: _username,
      autofocus: true,
      style: TextStyle(fontSize: 18, color: Colors.black),
      decoration: const InputDecoration(
        labelText: "Nhập username",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }

  Widget buildAddPass() {
    return TextField(
      controller: _pass,
      obscureText: true,
      style: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: const InputDecoration(
        labelText: "Nhập pass",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }

  Widget buildAddAcc() {
    return TextField(
      controller: _acacount,
      style: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: const InputDecoration(
        labelText: "Nhập ac acount",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }

  Widget buildAddAccPass() {
    return TextField(
      controller: _acpass,
      obscureText: true,
      style: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: const InputDecoration(
        labelText: "Nhập ac pass",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }

  Widget buildAddPattern() {
    return TextField(
      controller: _pattern,
      style: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: const InputDecoration(
        labelText: "Nhập pattern",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }

  Widget buildAddSerial() {
    return TextField(
      controller: _serial,
      style: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: const InputDecoration(
        labelText: "Nhập serial",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }
}
