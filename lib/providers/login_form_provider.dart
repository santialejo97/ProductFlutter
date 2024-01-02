import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formkey =  GlobalKey<FormState>();

  String email = '';
  String password = '';

   bool _isLoading = false;

  bool get isLoading{
    return _isLoading;
  }

  set isLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm(){
    return formkey.currentState?.validate() ?? false;
  }

  
}