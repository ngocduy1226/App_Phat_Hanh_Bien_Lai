// import 'package:flutter/material.dart';
// import 'package:myshop/ui/configuration/config_manager.dart';
// import 'package:myshop/ui/configuration/edit_config_screen.dart';
// import 'package:provider/provider.dart';
// import '../../models/config.dart';
// import '../shared/dialog_utils.dart';

// class ConfigListTile extends StatelessWidget {
//   final Config config;
//   const ConfigListTile(
//     this.config, {
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//               color: const Color(0xFF000000),
//               width: 1.0,
//               style: BorderStyle.solid),
//           borderRadius: BorderRadius.all(
//             Radius.circular(10),
//           ), //BorderRadius.all
//         ),
//         child: ListTile(
//           title: Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: SizedBox(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(config.urlservice,
//                       style: TextStyle(color: Colors.black)),
//                   Text(config.username, style: TextStyle(color: Colors.black)),
//                   Text(config.pass, style: TextStyle(color: Colors.black)),
//                   Text(config.acacount, style: TextStyle(color: Colors.black)),
//                   Text(config.acpass, style: TextStyle(color: Colors.black)),
//                   Text(config.pattern, style: TextStyle(color: Colors.black)),
//                   Text(config.serial, style: TextStyle(color: Colors.black)),
//                 ],
//               ),
//             ),
//           ),
//           trailing: SizedBox(
//             width: 100,
//             child: Row(children: <Widget>[
//               buildEditButton(context),
//               buildDeleteButton(context),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildEditButton(BuildContext context) {
//     return IconButton(
//       color: Colors.purple,
//       icon: const Icon(Icons.edit),
//       onPressed: () {
//         // print('edit config');
//         Navigator.of(context).pushNamed(
//           EditConfigScreen.routeName,
//           arguments: config.id,
//         );
//       },
//     );
//   }

//   Widget buildDeleteButton(BuildContext context) {
//     return IconButton(
//         icon: const Icon(Icons.delete),
//         onPressed: () async {
//           final shouldDelete = await showConfirmDialog(
//               context, "Bạn muốn xóa cấu hình đang chọn ?", "Xóa cấu hình");
  

//           if (shouldDelete!) {
//             context.read<ConfigManager>().deleteConfig(config.id!);
//             ScaffoldMessenger.of(context)
//               ..hideCurrentSnackBar()
//               ..showSnackBar(const SnackBar(
//                 content: Text(
//                   'Cấu hình đã được xóa',
//                   textAlign: TextAlign.center,
//                 ),
//               ));
//           }
//         },
//         color: Theme.of(context).colorScheme.error);
//   }
// }
