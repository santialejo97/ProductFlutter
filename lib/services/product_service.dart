import 'dart:convert';

import 'package:fl_productos/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ProductService extends ChangeNotifier{

  final String _baseUrl = 'flutter-proyects-9f9d6-default-rtdb.firebaseio.com';

  final List<ProductModel> products = [];

  late ProductModel selectedProduct;

  bool isLoading = true;
  bool isSaving = false;

  ProductService(){
    uploadProduct();
  }


  Future<List<ProductModel>> uploadProduct() async{

    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json' );
    final resp = await http.get(url);
    final Map<String, dynamic> productMap = json.decode(resp.body);
    productMap.forEach((key, value) {
      if(value != null){
        final tempProduct = ProductModel.fromJson(value);
        tempProduct.id = key ;
        products.add(tempProduct);
      }
    });

    isLoading = false;
    notifyListeners();
    return products;
  }



  Future saveOrUpdateProduct(ProductModel product) async{

    isSaving = true;
    notifyListeners();

    if(product.id == null){
      await createProduct(product);
    }else{
      updateProduct(product);
    }


    isSaving = false;
    notifyListeners();
    
  }


  Future<String> updateProduct(ProductModel product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json' );
    final resp = await http.put(url, body: product.toRawJson());
    final decodeData = resp.body;
    final int index = products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;
    notifyListeners();

    return product.id!;
  }

  Future<String> createProduct(ProductModel product) async {
    final url = Uri.https(_baseUrl, 'products.json' );
    final resp = await http.post(url, body: product.toRawJson());
    final decodeData =json.decode(resp.body) ;
    print(decodeData);
    product.id = decodeData['name'];
    this.products.add(product);
    notifyListeners();

    return product.id!;
  }


}