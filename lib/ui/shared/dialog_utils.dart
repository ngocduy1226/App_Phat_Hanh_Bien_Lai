import 'package:flutter/material.dart';

Future<bool?> showConfirmDialog(BuildContext context, String message, String title){
  return showDialog(
    context: context, 
    builder: (ctx) => AlertDialog(
      title:   Text(title),
      content: Text(
        message,
        style:  const TextStyle(color: Colors.black),
        ),
      actions: <Widget>[
        TextButton(
          child: const Text('Đóng'),
          onPressed: (){
            Navigator.of(ctx).pop(false);
          },
        ),
        TextButton(
          child: const Text('Xóa'),
          onPressed: (){
            Navigator.of(ctx).pop(true);
          },
        ),
      ],
    ),
  );
}

Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Xảy ra lỗi!'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('Okay'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
}