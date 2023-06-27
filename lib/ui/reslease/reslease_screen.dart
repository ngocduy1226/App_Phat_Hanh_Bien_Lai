
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



import '../receipt.dart/receipt.dart';
import '../shared/SQLDB.dart';
import '../shared/dialog_utils.dart';

SQLdb sqLdb = SQLdb();
//-----------------------------------------------
Future<List<Map>> getAllBrands() async {
  List<Map> brands = await sqLdb.getData("SELECT * FROM 'brands'");
  return brands;
}

class ResLeaseScreen extends StatefulWidget {
  const ResLeaseScreen({Key? key}) : super(key: key);
  @override
  State<ResLeaseScreen> createState() => _ResLeaseScreenState();
}

class _ResLeaseScreenState extends State<ResLeaseScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _brand = TextEditingController();
  TextEditingController _quantity = TextEditingController();
//  TextEditingController _total = TextEditingController();
  double denominations = 0.0;

  //String radioItem = 'Mango';

  double total = 0.0;
  int id = 1;

//--------Hàm buttom phát hành-----------------
  Future<void>  Reslease() async {
    if (_name.text == null || _name.text == "") {
      showMessage( context ,"Lỗi nhập liệu", "Vui lòng nhập họ và tên!");
      return;
    }
    if (_address.text == null || _address.text == "") {
      showMessage(  context, "Lỗi nhập liệu", "Vui lòng nhập địa chỉ!");
      return;
    }
    if (_brand == null) {
      showMessage(context,"Lỗi nhập liệu", "Vui lòng chọn nội dung thanh toán");
      return;
    }
    if (_quantity.text == null || _quantity.text == "") {
      showMessage(context, "Lỗi nhập liệu", "Vui lòng nhập số lượng!");
      return;
    } else {
      int yes = await sqLdb.insertData(
          "INSERT INTO 'receipts' (name,address, brand, quantity, total) VALUES ('${_name.text}', '${_address.text}', '${id}',${double.parse(_quantity.text)}, '${total}')");

      if (yes > 0) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => ReceiptScreen()),
            (route) => false);
      } else {
        showErrorDialog(context, "Phát hành không thành công");
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Phát hàng"),
        actions: <Widget>[
          buildRes(context),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 18,
              ),
              buildName(),
              const SizedBox(
                height: 10,
              ),
              buildAddress(),
              const SizedBox(
                height: 10,
              ),
              buildTitleBrand(),
              buildListBrand(),
              const SizedBox(
                height: 20,
              ),
              buildQuantity(),
              const SizedBox(
                height: 10,
              ),
              buildTotal(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName() {
    return TextFormField(
      controller: _name,
      style: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: InputDecoration(
        labelText: "Nhập họ và tên",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget buildAddress() {
    return TextFormField(
      controller: _address,
      style: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: InputDecoration(
        labelText: "Nhập địa chỉ",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget buildQuantity() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _quantity,
      style: const TextStyle(fontSize: 18, color: Colors.black),
      decoration: InputDecoration(
        labelText: "Nhập số lượng",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onChanged: (val) {
        print(_quantity.text);
        setState(() {
          total = double.parse(_quantity.text) * denominations;
        });
        print(total);
      },
    );
  }

  Widget buildTotal() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SizedBox(
        width: 400,
        height: 63,
        child: ListTile(
            leading: Text(
              'Tổng tiền:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            trailing: Text(
                '${NumberFormat('###,###', 'en_US').format(total ?? 0)}',
                style: TextStyle(fontSize: 23))),
      ),
    );
  }

  Widget buildTitleBrand() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black45,
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const SizedBox(
        width: 400,
        height: 63,
        child: ListTile(
            leading: Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Text(
                'Nội dung',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            trailing: Text(
              'Số tiền',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            )),
      ),
    );
  }

  Widget buildListBrand() {
    return SizedBox(
      child: FutureBuilder(
        future: getAllBrands(),
        builder: (context, snp) {
          if (snp.hasData) {
            List<Map> listBrands = snp.data!;
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black45,
                  style: BorderStyle.solid,
                  width: 1.0,
                ),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: listBrands
                    .map((data) => RadioListTile(
                          title: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text("${data['content']}"),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: Text(
                                      "${NumberFormat('###,###', 'en_US').format(double.tryParse(data['denominations'].toString()) ?? 0)} đ"),
                                ),
                              ),
                            ],
                          ),
                          groupValue: id,
                          value: data['id'],
                          onChanged: (val) {
                            setState(() {
                              _brand.text = data['content'];
//                          _brand.text = data['id'];
                              denominations = data['denominations'];
                              id = data['id'];
                              if (_quantity.text == "") {
                                _quantity.text = "0";
                              }
                              total =
                                  double.parse(_quantity.text) * denominations;
                            });
                            // print(denominations);
                          },
                        ))
                    .toList(),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildRes(BuildContext context) {
    return IconButton(
      onPressed: () async {
        // print("phat hanh");
        Reslease();
      },
      icon: const Icon(Icons.publish),
    );
  }

  
  
}
