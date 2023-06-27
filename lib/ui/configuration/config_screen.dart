import 'package:flutter/material.dart';

import 'package:myshop/ui/configuration/edit_config_screen.dart';
import 'package:myshop/ui/shared/dialog_utils.dart';
import 'package:intl/intl.dart';

import '../shared/SQLDB.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({Key? key}) : super(key: key);

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  SQLdb sqLdb = SQLdb();
  //-----------------------------------------------
  Future<List<Map>> getAllConfigs() async {
    List<Map> configs = await sqLdb.getData("SELECT * FROM 'configs'");
    return configs;
  }

    List<Map> _allData = [];
  bool _isLoading = true;

  void _refreshData() async {
    final data = await getAllConfigs();
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
        title: const Text("Cấu hình"),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
      body: _isLoading
      ? const Center(
        child: CircularProgressIndicator(),
      )
       :RefreshIndicator(
          onRefresh: () async {
              final data = await getAllConfigs();
                // print(data);
                setState(() {
                  _allData = data;
                  _isLoading = false;
                });
          },
         child: FutureBuilder(
          future: getAllConfigs(),
          builder: (ctx, snp) {
            if (snp.hasData) {
              _allData = snp.data!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount:  _allData.length,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromARGB(255, 66, 65, 65),
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                ),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                      child: SizedBox(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "${ _allData[index]['urlservice']}",
                                              style: const TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "${ _allData[index]['username']}",
                                              style: const TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "${ _allData[index]['pass']}",
                                              style: const TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "${ _allData[index]['acacount']}",
                                              style: const TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "${ _allData[index]['acpass']}",
                                              style: const TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "${ _allData[index]['pattern']}",
                                              style: const TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "${ _allData[index]['serial']}",
                                              style: const TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UpdateConfig(
                                                            id:  _allData[index]
                                                                ['id'],
                                                            urlservice:
                                                                 _allData[index]
                                                                    ['urlservice'],
                                                            username:
                                                                _allData[index][
                                                                    'username'],
                                                            pass:
                                                                _allData[index][
                                                                    'pass'],
                                                            acacount:
                                                                 _allData[index][
                                                                    'acacount'],
                                                            acpass:
                                                                _allData[index][
                                                                    'acpass'],
                                                            pattern:
                                                                 _allData[index][
                                                                    'pattern'],
                                                            serial:
                                                                _allData[index][
                                                                    'serial'],
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
                                                      "Bạn muốn xóa cấu hình đang chọn ?",
                                                      "Xóa cấu hình");
       
                                              if (shouldDelete!) {
                                                int rep = await sqLdb.deleteData(
                                                    "DELETE FROM 'configs' WHERE id = ${ _allData[index]['id']}");
                                                if (rep > 0) {
                                                  ScaffoldMessenger.of(context)
                                                    ..hideCurrentSnackBar()
                                                    ..showSnackBar(const SnackBar(
                                                        content: Text(
                                                      'Cấu hình đã được xóa',
                                                      textAlign: TextAlign.center,
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
                                  ),
                                ],
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
          Navigator.of(context).pushNamed("addConfig");
        },
        icon: const Icon(Icons.add));
  }
}
