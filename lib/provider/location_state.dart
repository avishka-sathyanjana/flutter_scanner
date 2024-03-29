import 'package:flutter/material.dart';
import '/model_data/login_remember.dart';
import '/model_data/LocationCode.dart';
import '/model_data/drop_dwon_data.dart';


class LocationProvider extends ChangeNotifier{

  LocationCode _locationCode=LocationCode(locationCode: '');
  String get location=>_locationCode.locationCode;

  void updateLocation(String newLocation) {
    _locationCode= LocationCode(locationCode:newLocation);
    notifyListeners();
  }
}

class DropDwonIssue extends ChangeNotifier{
  DropDwonDateIssues  _dropDwonDate=DropDwonDateIssues(issueType:'');
  String get issueType=>_dropDwonDate.issueType;


  void updateValue(String issueType){
    _dropDwonDate=DropDwonDateIssues(issueType: issueType);
    notifyListeners();

  }
}

class DropDwonCondition extends ChangeNotifier{
  DropDwonDataCondition _dropDwonDate=DropDwonDataCondition(itemCondition:'');
  String get itemCondition=>_dropDwonDate.itemCondition;

  void updateValue(String itemCondition){
    _dropDwonDate=DropDwonDataCondition(itemCondition: itemCondition);
    notifyListeners();

  }
}

class DropDwonData extends ChangeNotifier{
  DropData _dropData=DropData(value: '');
  String get value=>_dropData.value;
  void dropValue(String value){
    _dropData=DropData(value: value);
  }
}
class IsLoginRemember extends ChangeNotifier{
   LoginRemember _loginRemember=LoginRemember(isLogin: false);
  bool get value=>_loginRemember.isLogin;
  void valueUpdate(bool value){
    _loginRemember=LoginRemember(isLogin: value);
  }
}