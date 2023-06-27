import 'package:flutter/material.dart';
import 'package:myshop/SQLDB.dart';
import 'package:myshop/ui/configuration/config_screen.dart';

import '../shared/dialog_utils.dart';

class UpdateConfig extends StatefulWidget {
  final id;
  final urlservice;
  final username;
  final pass;
  final acacount;
  final acpass;
  final pattern;
  final serial;
  const UpdateConfig(
      {Key? key,
      this.id,
      this.urlservice,
      this.username,
      this.pass,
      this.acacount,
      this.acpass,
      this.pattern,
      this.serial})
      : super(key: key);

  @override
  State<UpdateConfig> createState() => _UpdateConfigState();
}

class _UpdateConfigState extends State<UpdateConfig> {
  TextEditingController _urlservice = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _acacount = TextEditingController();
  TextEditingController _acpass = TextEditingController();
  TextEditingController _pattern = TextEditingController();
  TextEditingController _serial = TextEditingController();
  SQLdb sqLdb = SQLdb();

  //--------Hàm buttom phát hành-----------------
  Future<void> UpdateConfig() async {
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
      int yes = await sqLdb.updateData('''
                      UPDATE "configs" SET
                      urlservice  = "${_urlservice.text}",
                      username = "${_username.text}",
                      pass = "${_pass.text}",
                      acacount = "${_acacount.text}",
                      acpass = "${_acpass.text}",
                      pattern = "${_pattern.text}",
                      serial = "${_serial.text}"
                      WHERE id = "${widget.id}"
                    ''');

      if (yes > 0) {
        Navigator.of(context).pop();

        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => ReceiptScreen()),
        //     (route) => false);
      } else {
        showErrorDialog(context, "Thay đổi cấu hình không thành công!");
      }
    }
  }

  @override
  void initState() {
    _urlservice.text = widget.urlservice;
    _username.text = widget.username;
    _pass.text = widget.pass;
    _acacount.text = widget.acacount;
    _acpass.text = widget.acpass;
    _pattern.text = widget.pattern;
    _serial.text = widget.serial;
    //TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cấu hình - Cập nhật"),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              UpdateConfig();
            },
            icon: const Icon(Icons.save, size: 20),
          )
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
              buildUpdateSer(),
              const SizedBox(
                height: 30,
              ),
              buildUpdateName(),
              const SizedBox(
                height: 30,
              ),
              buildUpdatePass(),
              const SizedBox(
                height: 30,
              ),
              buildUpdateAcc(),
              const SizedBox(
                height: 30,
              ),
              buildUpdateAccPass(),
              const SizedBox(
                height: 30,
              ),
              buildUpdatePattern(),
              const SizedBox(
                height: 30,
              ),
              buildUpdateSerial(),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUpdateSer() {
    return TextField(
      controller: _urlservice,
      style: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: const InputDecoration(
        labelText: "Nhập url service",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }

  Widget buildUpdateName() {
    return TextField(
      controller: _username,
      style: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: const InputDecoration(
        labelText: "Nhập username",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }

  Widget buildUpdatePass() {
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

  Widget buildUpdateAcc() {
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

  Widget buildUpdateAccPass() {
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

  Widget buildUpdatePattern() {
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

  Widget buildUpdateSerial() {
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
