import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/config.dart';
import '../shared/dialog_utils.dart';
import 'config_manager.dart';

class EditConfigScreen extends StatefulWidget {
  static const routeName = '/edit-config';
  EditConfigScreen(
    Config? config, {
    super.key,
  }) {
    if (config == null) {
      this.config = Config(
        id: null,
        urlservice: '',
        username: '',
        pass: '',
        acacount: '',
        acpass: '',
        pattern: '',
        serial: '',
      );
    } else {
      this.config = config;
    }
  }
  late final Config config;

  @override
  State<EditConfigScreen> createState() => _EditConfigScreenState();
}

class _EditConfigScreenState extends State<EditConfigScreen> {
  final _editForm = GlobalKey<FormState>();
  late Config _editedConfig;
  var _isLoading = false;

  @override
  void initState() {
    _editedConfig = widget.config;
    super.initState();
  }

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
      final configManager = context.read<ConfigManager>();
      if (_editedConfig.id != null) {
        configManager.updateConfig(_editedConfig);
      } else {
        configManager.addConfig(_editedConfig);
      }
    } catch (error) {
      await showErrorDialog(context, "Xảy ra lỗi");
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
    return Scaffold(
        appBar:
            AppBar(title: const Text('Cấu hình - Cập nhật'), actions: <Widget>[
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
                        child: buildUrlServiceField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: buildUsernameField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: buildPassField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: buildAccountField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: buildAcpassField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: buildPatternField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: buildSerialField(),
                      ),
                    ])),
              ));
  }

  TextFormField buildUrlServiceField() {
    return TextFormField(
      initialValue: _editedConfig.urlservice,
      decoration: const InputDecoration(labelText: 'Nhập url Service',border: OutlineInputBorder()),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nhập url service';
        }
        return null;
      },
      onSaved: (value) {
        _editedConfig = _editedConfig.copyWith(urlservice: value);
      },
    );
  }

  TextFormField buildUsernameField() {
    return TextFormField(
      initialValue: _editedConfig.username,
      decoration: const InputDecoration(labelText: 'Nhập username',border: OutlineInputBorder()),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nhập username';
        }
        return null;
      },
      onSaved: (value) {
        _editedConfig = _editedConfig.copyWith(username: value);
      },
    );
  }

  TextFormField buildPassField() {
    return TextFormField(
      initialValue: _editedConfig.pass,
      decoration: const InputDecoration(labelText: 'Nhập password', border: OutlineInputBorder()),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nhập password';
        }
        return null;
      },
      onSaved: (value) {
        _editedConfig = _editedConfig.copyWith(pass: value);
      },
    );
  }

  TextFormField buildAccountField() {
    return TextFormField(
      initialValue: _editedConfig.acacount,
      decoration: const InputDecoration(labelText: 'Nhập ac account', border: OutlineInputBorder()),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nhập ac account';
        }
        return null;
      },
      onSaved: (value) {
        _editedConfig = _editedConfig.copyWith(acacount: value);
      },
    );
  }

  TextFormField buildAcpassField() {
    return TextFormField(
      initialValue: _editedConfig.acpass,
      decoration: const InputDecoration(labelText: 'Nhập ac pass', border: OutlineInputBorder()),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nhập ac pass';
        }
        return null;
      },
      onSaved: (value) {
        _editedConfig = _editedConfig.copyWith(acpass: value);
      },
    );
  }

  TextFormField buildPatternField() {
    return TextFormField(
      initialValue: _editedConfig.pattern,
      decoration: const InputDecoration(labelText: 'Nhập pattern', border: OutlineInputBorder()),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nhập pattern';
        }
        return null;
      },
      onSaved: (value) {
        _editedConfig = _editedConfig.copyWith(pattern: value);
      },
    );
  }

  TextFormField buildSerialField() {
    return TextFormField(
      initialValue: _editedConfig.serial,
      decoration: const InputDecoration(labelText: 'Nhập serial', border: OutlineInputBorder()),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nhập serial';
        }
        return null;
      },
      onSaved: (value) {
        _editedConfig = _editedConfig.copyWith(serial: value);
      },
    );
  }

  Widget buildConfigPreview() {
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
