
import 'package:flutter/material.dart';

class LoginBackground extends CustomPainter {

  LoginBackground({@required this.isJoin});

  final bool isJoin ;  //final을 넣을 것인지 후 .. 넣으니까 실행이 안됨

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = isJoin?Colors.brown:Colors.yellow; //isJoin 이 true 라면 red ,false라면 yellow
    canvas.drawCircle(Offset(size.width*0.5,size.height*0.2), size.height*0.5, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}