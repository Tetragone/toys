import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MYCERTIPORTFOLIO extends StatefulWidget {
  @override
  _MYCERTIPORTFOLIOState createState() => _MYCERTIPORTFOLIOState();
}

class _MYCERTIPORTFOLIOState extends State<MYCERTIPORTFOLIO> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY자격증'),
      ),    );
  }
}