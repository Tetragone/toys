import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mycerthelper/data/join_or_login.dart';
import 'package:mycerthelper/helper/login_background.dart';
import 'package:mycerthelper/screens/forget_pw.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomPaint(
            size: size,
            painter: LoginBackground(isJoin: Provider.of<JoinOrLogin>(context).isJoin),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
            _logoImage,
              Stack(
                children: <Widget>[
                  _inputForm(size), //input form
                  _authButton(size),
                ],
              ),
              Container(
                height: size.height * 0.1,
              ),
              Consumer<JoinOrLogin>(
                builder: (context, joinOrLogin, child)=>
                    GestureDetector(
                    onTap: (){
                      joinOrLogin.toggle();

                    },
                    child: Text(joinOrLogin.isJoin?"이미 회원가입을 했나요? 로그인 하세요!":"아이디가 없으신가요? 회원가입 하세요!",
                        style: TextStyle(color:joinOrLogin.isJoin?Colors.red:Colors.brown),)),
                    ) ,

              Container(
                height: size.height * 0.05,
              )
            ],
          ),
        ],
      ),
    );
  }

void _register(BuildContext context) async {
    final AuthResult result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);
    final FirebaseUser user = result.user;

    if(user == null){
      final snacBar = SnackBar(content: Text('잠시 후 다시 시도해 주세요.'),);
      Scaffold.of(context).showSnackBar(snacBar);
    }

  } //계정 생성 !!

  void _login(BuildContext context) async {
    final AuthResult result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);
    final FirebaseUser user = result.user;

    if(user == null){
      final snacBar = SnackBar(content: Text('잠시 후 다시 시도해 주세요.'),);
      Scaffold.of(context).showSnackBar(snacBar);
    }

  } //로그인  !!

  Widget get _logoImage
=>  Expanded(
  child: Padding(
    padding: const EdgeInsets.only(top: 40, left: 24, right:24),
    child: FittedBox(
      fit: BoxFit.contain,
      child: CircleAvatar(
        backgroundImage: NetworkImage("http://edudonga.com/data/article/1807/325500368fc6f78a2c04c380709fe201_1532677223_694.jpg"), //이미지 넣고싶은 것 넣으면 된다.
         ),
    ),
  ),
);


  Widget _authButton(Size size) => Positioned(
        left: size.width * 0.15,
        right: size.width * 0.15,
        bottom: 0,
        child: SizedBox(
          height: 50,
        child: Consumer<JoinOrLogin>(
          builder: (context, joinOrLogin, child)=> RaisedButton(
              child: Text(
                  joinOrLogin.isJoin?"회원가입":"로그인",
                  style: TextStyle(fontSize:20, color: joinOrLogin.isJoin?Colors.white:Colors.brown),
              ),
              color: joinOrLogin.isJoin?Colors.brown:Colors.yellow,
              shape:
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
              onPressed: () {
                if(_formKey.currentState.validate()){
                  joinOrLogin.isJoin?_register(context):_login(context);
                }
              }),
        ),
        ),
      );

  Widget _inputForm(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12.0, right: 12, top: 12, bottom: 32),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      labelText: "비밀번호",
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "비밀번호를 다시 확인해주세요.";
                      }
                      return null;
                    },
                  ),
                  Container(height: 8),
                  Consumer<JoinOrLogin>(

                    builder: (context, value, child)=>Opacity( //투명함
                       opacity: value.isJoin?0:1,
                        child: GestureDetector(
                            onTap:value.isJoin
                                ?null
                                :(){
                              goToForgetPw(context);
                              },
                            child: Text("비밀번호가 기억안나요."))),
    ),
    ],
              )),

                  ),
      ),
                  );



  }
      goToForgetPw(BuildContext context){
      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPw()));
    }
  }
