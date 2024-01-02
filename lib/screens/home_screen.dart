import 'package:fl_productos/models/product_model.dart';
import 'package:fl_productos/screens/screens.dart';
import 'package:fl_productos/services/services.dart';
import 'package:fl_productos/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

    static String homeRoute = 'home';
   
  const HomeScreen({Key? key}) : super(key: key);

  
  
  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductService>(context);

    final List<ProductModel> products = productService.products; 

    return  Scaffold(
      appBar: AppBar(
        title:const Text('Productos'),
        centerTitle: true,
        ),
      body: !productService.isLoading 
            ? ListView.builder(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    productService.selectedProduct = products[index].copy();
                   Navigator.pushNamed(context, ProductScreen.productRouter);
                  },
                  child:  ProductCard(product: products[index],
                  )
                ),
                itemCount: products.length,)
            :const  LoadingScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productService.selectedProduct = ProductModel(
            available: true, 
            name: '', 
            price: 0, picture: '');
          Navigator.pushNamed(context, ProductScreen.productRouter);
        },
        child:const Icon(Icons.add),
      ),        
    );
  }
}