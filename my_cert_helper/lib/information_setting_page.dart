import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'main.dart';
import 'calendar_testinfo.dart';
import 'information_notification.dart';

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('자격증 정보')),
      body: InformationPage(),
    );
  }
}

class InformationPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            _buildPadding1(),
            _buildTop(context),
            _buildPadding2(),
            _buildBottom(context),
          ],
        ),
      ],
    );
  }

  // 상단 여백
  Widget _buildPadding1(){
    return Container(
      padding: EdgeInsets.all(5),
    );
  }

  // 슬라이드
  Widget _buildTop(BuildContext context){
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

    // 중간 여백
  Widget _buildPadding2(){
    return Container(
      padding: EdgeInsets.all(5),
    );
  }

  Widget _buildBottom(BuildContext context) {
      final items = List.generate(1, (i) {
      return Column(
        children : <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.alarm, color: Colors.white, size: 52.0),
              title: Text('공지사항'),
              subtitle: Text('시험 접수, 추가접수, 성적발표 알림'),
              onTap: () {
                Navigator.push(context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
                  return InfoNotification(); // 바로가기할 페이지
                }));
              },
            ),
            color: Colors.cyan[100],
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.category, color: Colors.cyan[100], size: 52.0),
              title: Text('자격증 정보 및 평가'),
              subtitle: Text('시험 필수정보, 자격증 평가 및 활용정보'),
              onTap: () {
                Navigator.push(context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
                  return editTestDay(); // 바로가기할 페이지
                }));
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.attach_money, color: Colors.cyan[100], size: 52.0),
              title: Text('중고장터'),
              subtitle: Text('자격증 교재, 강의 등 개인 간 중고거래'),
              onTap: () {
                Navigator.push(context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
                  return editTestDay(); // 바로가기할 페이지
                }));
              },
            ),
          ),                               
        ]
      );
    });

    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: items,
    );
  }
}