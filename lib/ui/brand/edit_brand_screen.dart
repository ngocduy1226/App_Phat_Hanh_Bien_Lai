import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/brand.dart';
import '../shared/dialog_utils.dart';

import 'brand_manager.dart';

class EditBrandScreen extends StatefulWidget {
  static const routeName = '/edit-brand';
  EditBrandScreen(
    Brand? brand, {
    super.key,
  }) {
    if (brand == null) {
      this.brand = Brand(
        id: null,
        content: '',
        denominations: 0,
      );
    } else {
      this.brand = brand;
    }
  }
  late final Brand brand;

  @override
  State<EditBrandScreen> createState() => _EditBrandScreenState();
}

class _EditBrandScreenState extends State<EditBrandScreen> {
  final _editForm = GlobalKey<FormState>();
  late Brand _editedBrand;
  var _isLoading = false;


  //khoi tao cac bien
  @override
  void initState() {
    _editedBrand = widget.brand;
    super.initState();
  }

  //giai phong bien
  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final brandManager = context.read<BrandManager>();
      if (_editedBrand.id != null) {
        brandManager.updateBrand(_editedBrand);
      } else {
        brandManager.addBrand(_editedBrand);
      }
    } catch (error) {
      await showErrorDialog(context, "Lỗi");
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
  
    const text = Text('Danh mục - Thêm');
    
    return Scaffold(
        appBar: AppBar(title: text, actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          )
        ]),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    key: _editForm,
                    child: ListView(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: buildDeMoNiField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: buildContentField(),
                      ),

                      // buildBrandPreview()
                    ])),
              ));
  }

  TextFormField buildContentField() {
    return TextFormField(
      initialValue: _editedBrand.content,
      decoration: const InputDecoration(
          labelText: 'Nhập nội dung', border: OutlineInputBorder()),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nhập nội dung';
        }
        return null;
      },
      onSaved: (value) {
        _editedBrand = _editedBrand.copyWith(content: value);
      },
    );
  }

  TextFormField buildDeMoNiField() {
    var  _amount= double.tryParse(_editedBrand.denominations.toString()) ?? 0;
    return TextFormField(
      initialValue: (NumberFormat('###,###','en_US').format(_amount)).toString(),
      decoration: const InputDecoration(
          labelText: 'Nhập mệnh giá', border: OutlineInputBorder()),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nhập mệnh giá';
        }
        if (double.tryParse(value) == null) {
          return "Mệnh giá không rỗng";
        }
        if (double.parse(value) <= 0) {
          return "Mệnh giá lớn hơn 0";
        }
        return null;
      },
      onSaved: (value) {
        _editedBrand =
            _editedBrand.copyWith(denominations: double.parse(value!));
      },
    );
  }

  Widget buildBrandPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(
            top: 8,
            right: 10,
          ),
          decoration: BoxDecoration(
              border: Border.all(
            width: 1,
            color: Colors.grey,
          )),
        )
      ],
    );
  }
}
