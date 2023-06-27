import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../SQLDB.dart';
import '../shared/number_toVietnamese.dart';
// import 'package:open_file/open_file.dart';

// import 'package:path_provider/path_provider.dart';

// import 'dart:convert';
// // import 'dart:html';
//import 'package:native_pdf_renderer/native_pdf_renderer.dart';
// import 'package:http/http.dart' as http;

class ReceiptScreen extends StatefulWidget {
  static const routeName = '/receipt';
  const ReceiptScreen({super.key});
  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  SQLdb sqLdb = SQLdb();

  //-----------------------------------------------
  Future<List<Map>> getAllReceipts() async {
    List<Map> reciepts = await sqLdb.getData(
        "SELECT * FROM 'receipts' WHERE id = (Select MAX(id) from receipts)");
    return reciepts;
  }

  //-----------------------------------------------
  @override
  Widget build(BuildContext context) {
    String adate =
        DateFormat("'Ngày' dd 'tháng' MM 'năm' yyyy").format(DateTime.now());
    String bdate = DateFormat("dd/MM/yyyy").format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Biên lai"),
        actions: [buildHome(context)],
      ),
      body: FutureBuilder(
        future: getAllReceipts(),
        builder: (ctx, snp) {
          if (snp.hasData) {
            List<Map> listRecs = snp.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: listRecs.length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 66, 65, 65),
                              style: BorderStyle.solid,
                              width: 3.0,
                            ),
                            color: Colors.transparent,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 300),
                            child: SizedBox(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildTitle(context),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Tên người nộp: ${listRecs[index]['name']}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Địa chỉ: ${listRecs[index]['address']}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Số tiền: ${NumberFormat('###,###', 'en_US').format(double.tryParse(listRecs[index]['total'].toString()) ?? 0)} đ",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Số tiền bằng chữ: " +
                                          NumberToVietnamese.convert(
                                              (listRecs[index]['total'])
                                                  .toInt()),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "$adate",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    buildSigner(context),
                                    Text(
                                      "Ký ngày: $bdate",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );

    // print(a);
  }
}

Widget buildTitle(BuildContext context) {
  return const Text(
    "Biên lai thu tiền thuế, phí, lệ phí ",
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget  buildSigner(BuildContext context) {
  return const Text(
    "Ký bởi: Biên Lai Test VNPT VLG",
    style: TextStyle(
      color: Colors.black,
      fontSize: 17,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget buildHome(BuildContext context) {
  return IconButton(
    onPressed: () {
      Navigator.of(context).pushNamed("appDrawer");
    },
    icon: const Icon(Icons.house),
  );
}

mixin $ {}
