import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'main.dart';

  /*
  'gs://certhelper-3e7f3.appspot.com/image/test_image1.PNG',
  'gs://certhelper-3e7f3.appspot.com/image/test_image2.PNG',
  'gs://certhelper-3e7f3.appspot.com/image/test_image3.PNG'
  */


final dummyItems = [
  'https://firebasestorage.googleapis.com/v0/b/certhelper-3e7f3.appspot.com/o/image%2Ftest_image1.PNG?alt=media&token=2e61859f-763d-4beb-9364-7859b68c84ac',
  'https://firebasestorage.googleapis.com/v0/b/certhelper-3e7f3.appspot.com/o/image%2Ftest_image2.PNG?alt=media&token=b562655c-7163-4186-a730-8384e67b291d',
  'https://firebasestorage.googleapis.com/v0/b/certhelper-3e7f3.appspot.com/o/image%2Ftest_image3.PNG?alt=media&token=712aceae-c962-40b1-8f33-f76e6fc728b1'
];

class InformationSettingPage extends StatefulWidget{

  @override
  State createState() => InformationSettingPageState();
}

class InformationSettingPageState extends State<InformationSettingPage>{

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildPadding1(),
        //_buildPadding2(),
        _buildTop(),
        //_buildBottom(),
      ],
    );
  }

  // 상단 여백
  Widget _buildPadding1(){
    return Container(
      padding: EdgeInsets.all(10),
    );
  }

  // 슬라이드
  Widget _buildTop(){
    return CarouselSlider(
      options: CarouselOptions(
      autoPlay: true,
      height: 150,
      ),
      items: dummyItems.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }
        );
      }).toList()
    );
  }
/*
    // 상단 여백
  Widget _buildPadding2(){
    return Container(
      padding: EdgeInsets.all(10),
    );
  }
*/
  Widget _buildBottom(){
    GridView.count(
      crossAxisCount: 2,
      children: List.generate(4, (index) {
        return Center(
          child: Text('Item $index', style: Theme.of(context).textTheme.headline,),
        );
      }),
    );
  }
}


/*
children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text("자격증 시험 공지사항"),
          color: Colors.teal[100],
      ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('자격증 활용정보'),
          color: Colors.teal[200],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('자격증 평가'),
          color: Colors.teal[300],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: const Text('교재 사고팔기'),
          color: Colors.teal[400],
        ),
      ],
*/