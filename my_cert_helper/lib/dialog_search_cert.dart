import 'package:flutter/material.dart';
import 'package:mycerthelper/page_test_setting.dart';

class UIChooseCertOption extends SimpleDialogOption {
  String name;

  UIChooseCertOption(String name, TestSettingPageState superClass)
      : this.name = name,
        super
          (
            onPressed: () {
              superClass.selectedName = name;
              Navigator.pop(superClass.context, name);
            },
            child: Text(name)
        );
}