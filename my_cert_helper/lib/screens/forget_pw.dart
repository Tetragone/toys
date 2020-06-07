import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPw extends StatefulWidget {
  @override
  _ForgetPwState createState() => _ForgetPwState();
}

class _ForgetPwState extends State<ForgetPw> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비밀번호가 기억안나요.'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                icon: Icon(Icons.account_circle),
                labelText: "이메일",
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return "이메일을 다시 확인해주세요.";
                }
                return null;
              },
            ),
            FlatButton(onPressed: ()async{

              // ignore: unnecessary_statements
              await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
              final snacBar = SnackBar(
                content: Text('비밀번호 재설정을 위해 이메일을 확인해 주세요.'),
    );
                Scaffold.of(_formKey.currentContext).showSnackBar(snacBar);


            },child: Text('비밀번호 재설정'))
          ],
        ),
      ),
    );
  }
}
