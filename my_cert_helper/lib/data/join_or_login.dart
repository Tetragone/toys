import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class JoinOrLogin extends ChangeNotifier{ //join 상태인지 login 상태인지
  bool _isJoin = false;

  bool get isJoin => _isJoin;   //알림메시지

  void toggle(){ //한번씩 바꿔주는 것 트루이면 펄스로 펄스면 트루로
    _isJoin = !_isJoin;
    notifyListeners(); //

  }

}