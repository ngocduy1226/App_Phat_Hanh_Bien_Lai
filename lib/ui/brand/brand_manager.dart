import '../../models/brand.dart';

class BrandManager {
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
}
