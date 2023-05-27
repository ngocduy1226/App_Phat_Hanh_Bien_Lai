
import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';

// import 'package:path_provider/path_provider.dart';

// import 'dart:convert';
// // import 'dart:html';
//import 'package:native_pdf_renderer/native_pdf_renderer.dart';
// import 'package:http/http.dart' as http;

class ResLeaseScreen extends StatefulWidget {
  static const routeName = '/reslease';
  const ResLeaseScreen({super.key});

  @override
  State<ResLeaseScreen> createState() => _ResLeaseScreenState();
}

class _ResLeaseScreenState extends State<ResLeaseScreen> {
  

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Phát hành'),
        // actions: <Widget>[
        //   buildAddButton(context),
        // ],
      ),
     
      body: Container(
      child: Text('form them phat hanh.'),
    )
    );

  }
}
