import 'package:flutter/material.dart';
import 'package:mycerthelper/page_test_setting.dart';

import 'information_review_page.dart';

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

/*
class UIChooseCertOption2 extends SimpleDialogOption {
  String name;
  String orga;
  String classifi;

  UIChooseCertOption2(String name, ReviewPageState superClass, String orga, String classifi)
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
*/
