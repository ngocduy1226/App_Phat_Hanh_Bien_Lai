import 'package:flutter/foundation.dart';
import '../../models/brand.dart';

class BrandManager with ChangeNotifier {
  final List<Brand> _brandList = [
    Brand(
      id: 'p1',
      title: 'aaa',
      content: '1,000d',
    ),
    Brand(
      id: 'p1',
      title: 'aaa',
      content: '2,500d',
    ),
  ];

  int get itemCount {
    return _brandList.length;
  }

  List<Brand> get brandList {
    return [..._brandList];
  }

  void addBrand(Brand brand) {
    _brandList.add(
      brand.copyWith(
        id: 'p${DateTime.now().toIso8601String()}',
      ),
    );
    notifyListeners();
  }

  void updateBrand(Brand brand) {
    final index = _brandList.indexWhere((element) => element.id == brand.id);
    if (index >= 0) {
      _brandList[index] = brand;
      notifyListeners();
    }
  }

  void deleteBrand(String id) {
    final index = _brandList.indexWhere((element) => element.id == id);
    _brandList.removeAt(index);
    notifyListeners();
  }
}
