import 'package:implementa_mvc/models/click.dart';

class ClickController{
  // tipo nome_atributo = valor;
  // tipo nome_atributo = construtor();
  Click _click = Click();

  int get count => _click.count;
  // int getCount(){
  //   return _click.count;
  // }

  void increment(){
    _click.increment();
  }
  
}