import 'package:flutter/cupertino.dart';
import 'package:task/userModel.dart';

class Updater with ChangeNotifier{
UserModel? model;
UserModel? get _model=>model;
getData(list){
  model=list;
  notifyListeners();
}
}