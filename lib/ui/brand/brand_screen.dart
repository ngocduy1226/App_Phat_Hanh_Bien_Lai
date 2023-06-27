import 'package:flutter/material.dart';
import 'package:myshop/SQLDB.dart';
import 'package:myshop/ui/shared/dialog_utils.dart';
import 'package:myshop/ui/brand/edit_brand_screen.dart';
import 'package:intl/intl.dart';


// import 'package:open_file/open_file.dart';

// import 'package:path_provider/path_provider.dart';

// import 'dart:convert';
// // import 'dart:html';
//import 'package:native_pdf_renderer/native_pdf_renderer.dart';
// import 'package:http/http.dart' as http;

class BrandScreen extends StatefulWidget {
  const BrandScreen({Key? key}) : super(key: key);

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  SQLdb sqLdb = SQLdb();
  //-----------------------------------------------
  Future<List<Map>> getAllBrands() async {
    List<Map> brands = await sqLdb.getData("SELECT * FROM 'brands'");
    return brands;
  }

  List<Map> _allData = [];
  bool _isLoading = true;

  void _refreshData() async {
    final data = await getAllBrands();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
    // print(data);
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  //-----------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh mục"),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                final data = await getAllBrands();
                // print(data);
                setState(() {
                  _allData = data;
                  _isLoading = false;
                });
              },
              child: FutureBuilder(
                future: getAllBrands(),
                builder: (ctx, snp) {
                  if (snp.hasData) {
                    _allData = snp.data!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: _allData.length,
                          itemBuilder: (ctx, index) {
                            return Column(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 66, 65, 65),
                                        style: BorderStyle.solid,
                                        width: 2.0,
                                      ),
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        "${_allData[index]['content']}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      subtitle: Text(
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 161, 161, 161),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          "${NumberFormat('###,###', 'en_US').format(double.tryParse(_allData[index]['denominations'].toString()) ?? 0)} đ"),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UpdateBrand(
                                                              id: _allData[
                                                                  index]['id'],
                                                              content: _allData[
                                                                      index]
                                                                  ['content'],
                                                              denominations:
                                                                  _allData[
                                                                          index]
                                                                      [
                                                                      'denominations'],
                                                            )));
                                            
                                              },
                                              child: const Icon(
                                                Icons.edit,
                                                color: Colors.purple,
                                                size: 25,
                                              )),
                                          TextButton(
                                              onPressed: () async {
                                                final shouldDelete =
                                                    await showConfirmDialog(
                                                        context,
                                                        "Bạn muốn xóa danh mục đang chọn ?",
                                                        "Xóa danh mục");

                                                if (shouldDelete!) {
                                                  int rep = await sqLdb.deleteData(
                                                      "DELETE FROM 'brands' WHERE id = ${_allData[index]['id']}");
                                                  if (rep > 0) {
                                                    ScaffoldMessenger.of(
                                                        context)
                                                      ..hideCurrentSnackBar()
                                                      ..showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                        'Danh mục đã được xóa',
                                                        textAlign:
                                                            TextAlign.center,
                                                      )));

                                                    setState(() {});
                                                  }
                                                }
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 25,
                                              ))
                                        ],
                                      ),
                                    )),
                                const Divider(),
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
            ),
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addBrand");
        },
        icon: const Icon(Icons.add));
  }
}
