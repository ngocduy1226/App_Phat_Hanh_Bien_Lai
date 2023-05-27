import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myshop/ui/configuration/edit_config.dart';
import 'config_list.dart';
import 'config_manager.dart';
import '../shared/app_nav.dart';

class ConfigScreen extends StatelessWidget {
  static const routeName = '/config-list';
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final configManager = ConfigManager();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cấu hình'),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
      body: RefreshIndicator(
        child: buildConfigListView(configManager),
        onRefresh: () async => print('refresh config'),
      ),
    );
  }

  Widget buildConfigListView(ConfigManager configManager) {
    return Consumer<ConfigManager>(builder: (ctx, configManager, child) {
      return ListView.builder(
          itemCount: configManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              ConfigListTile(configManager.items[i]),
              const Divider(),
            ],
          ));
    });
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditConfigScreen.routeName,
        );
      },
    );
  }
}
