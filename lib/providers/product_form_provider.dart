import 'package:fl_productos/models/models.dart';
import 'package:flutter/material.dart';

class ProductFormProvider extends ChangeNotifier{

  GlobalKey<FormState> globalKeyFormProduct = GlobalKey<FormState>();

  ProductModel product ;

  ProductFormProvider(this.product);

  updateAvaliable(bool value){
    product.available = value;
    notifyListeners();
  }


  bool isValidForm(){
    print('Validamos el formulario');

    return globalKeyFormProduct.currentState?.validate() ?? false;
  }
}