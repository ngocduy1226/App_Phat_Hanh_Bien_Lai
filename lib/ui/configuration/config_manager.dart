import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../../models/config.dart';

class ConfigManager with ChangeNotifier{
  final List<Config> _items = [
    Config(
      id: 'c1',
      urlservice: 'https://vnptvinhlongbldtadmindemo.vnpt-invoice.com.vn/PublishService.asmx',
      username: 'vnptvinhlongbldtservice',
      pass: 'Einv@oi@vn#pt20',
      acacount: 'vnptvinhlongbldtadmin',
      acpass: 'Einv@oi@vn#pt20',
      pattern: '01BLP0-001',
      serial: 'AA-22E'
    ),
    Config(
      id: 'c2',
      urlservice: ' https://vnptvinhlongbldtadmindemo.vnpt-invoice.com.vn/PortalService.asmx',
      username: 'vnptvinhlongbldtservice',
      pass: 'Einv@oi@vn#pt20',
      acacount: 'vnptvinhlongbldtadmin',
      acpass: 'Einv@oi@vn#pt20',
      pattern: '01BLP0-001',
      serial: 'AA-22E'
    ),
  ];
   int get itemCount {
    return _items.length;
  }

  List<Config> get items {
    return [..._items];
  }

  Config? findById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (error) {
      return null;
    }
  }
  void addConfig(Config config) {
    _items.add(
      config.copyWith(
        id: 'p${DateTime.now().toIso8601String()}',
      ),
    );
    notifyListeners();
  }

  void updateConfig(Config config) {
    final index = _items.indexWhere((item) => item.id == config.id);
    if (index >= 0) {
      _items[index] = config;
      notifyListeners();
    }
  }

  void deleteConfig(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    _items.removeAt(index);
    notifyListeners();
  }
}