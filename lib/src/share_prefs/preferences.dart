import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _instancia = SharedPrefs._internal();

  factory SharedPrefs() {
    return _instancia;
  }
  SharedPrefs._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get token{
    return _prefs.getString('token');
  }

  set token(String token){
    _prefs.setString('token', token);
  }

  get user {
    return _prefs.getString('user');
  }

  set user(String user) {
    _prefs.setString('user', user);
  }

  get remember {
    return _prefs.getBool('remember') ?? false;
  }

  set remember(bool flag) {
    _prefs.setBool('remember', flag);
  }

  get email {
    return _prefs.getString('email');
  }

  set email(String email) {
    _prefs.setString('email', email);
  }

  get emailPin {
    return _prefs.getString('emailPin');
  }

  set emailPin(String email) {
    _prefs.setString('emailPin', email);
  }

  get endToken{
    return _prefs.getBool('endtoken') ?? false;
  }

  set endToken(bool flag) {
    _prefs.setBool('endtoken', flag);
  }

  get startRoute{
    return _prefs.getString('startroute') ?? '/';
  }

  set startRoute(String route){
    _prefs.setString('startroute', route);
  }

  get date{
    return _prefs.getString('date') ?? null;
  }

  set date(String date){
    _prefs.setString('date', date);
  }

  get pin{
    return _prefs.getInt('pin') ?? -1;
  }

  set pin(int pin){
    _prefs.setInt('pin', pin);
  }

}
