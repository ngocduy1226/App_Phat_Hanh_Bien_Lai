import 'package:flutter/foundation.dart';
import '../../models/brand.dart';

class BrandManager with ChangeNotifier {
  final List<Brand> _brandList = [
    Brand(
      id: 'p1',
      content: 'aaa',
      denominations: 1.000,
    ),
    Brand(
      id: 'p2',
      content: 'bbb',
      denominations: 2.500,
    ),
  ];

  int get itemCount {
    return _brandList.length;
  }

  List<Brand> get brandList {
    return [..._brandList];
  }

   Brand? findById(String id) {
    try {
      return _brandList.firstWhere((item) => item.id == id);
    } catch (error) {
      return null;
    }
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
