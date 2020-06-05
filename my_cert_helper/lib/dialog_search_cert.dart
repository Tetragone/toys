import 'package:flutter/material.dart';
import 'package:mycerthelper/page_test_setting.dart';

class UIChooseCertOption extends SimpleDialogOption {
  String name;
  String orga;
  String classifi;

  UIChooseCertOption(String name, TestSettingPageState superClass, String orga, String classifi)
      : this.name = name,
        this.orga = orga,
        this.classifi = classifi,
        super
          (
            onPressed: () {
              superClass.selectedName = name;
              superClass.selectedClass = classifi;
              superClass.selectedOrga = orga;
              Navigator.pop(superClass.context, name);
            },
            child: Text(name)
        );
}