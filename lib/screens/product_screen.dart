import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:fl_productos/models/models.dart';
import 'package:fl_productos/providers/provider.dart';
import 'package:fl_productos/services/services.dart';
import 'package:fl_productos/ui/input_decorations.dart';
import 'package:fl_productos/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
   
  const ProductScreen({Key? key}) : super(key: key);

  static String productRouter = 'Product';
  
  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductService>(context);

    final ProductModel product = productService.selectedProduct;

    return  ChangeNotifierProvider(
      create: (BuildContext context) => ProductFormProvider(product),
      child: _ProductScreenBody(product: product, productService: productService,));
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    super.key,
    required this.product, 
    required this.productService,
  });

  final ProductModel product;
  final ProductService productService;

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(picture: product.picture),
    
                Positioned(
                  top: 50,
                  left: 30,
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon:const Icon(Icons.arrow_back_ios_new_outlined, size: 50, color: Colors.white,),)
                  ),
    
                Positioned(
                  top: 50,
                  right: 30,
                  child: IconButton(onPressed: (){
                    // TODO: CAMARA O GALERIA DEL CELULAR 
                  }, icon:const Icon(Icons.camera_alt_outlined, size: 50, color: Colors.white,)))
              ],
            ),
    
            const _FormProduct(),
            
            const SizedBox(height: 100,)
    
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{
        if(!productForm.isValidForm()) return;
        print('Se solicita la peticion de actualizacion de product');
        await productService.saveOrUpdateProduct(productForm.product);
      }, child:const Icon(Icons.save)),
    );
  }
}

class _FormProduct extends StatelessWidget {
  const _FormProduct({
    super.key,
  });


  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.only( right: 20, left: 20),
      child: Container(
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.globalKeyFormProduct,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
              children: [
                const  SizedBox(height: 50,),
                TextFormField(
                  initialValue: product.name,
                  onChanged: (value) => product.name = value,
                  validator: (value){
                    if(value == null || value.isEmpty)
                    return 'El name es obligatorio';
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecorations.inputDecorations(
                    hintText: 'Name of Product', 
                    labelText: 'Name:', 
                    helperText: 'Add Name of product', 
                    prefixIcon: Icons.pie_chart_rounded
                  )
                ),
                const SizedBox(height: 30,),

                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  initialValue: product.price.toString(),
                  onChanged: (value) {
                    if(double.tryParse(value) == null){
                      product.price= 0;
                    }else{
                      product.price = double.parse(value);
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.inputDecorations(
                    hintText: 'Price of Product', 
                    labelText: 'Price:', 
                    helperText: 'Add Price of product', 
                    prefixIcon: Icons.price_check
                  )
                ),

                const SizedBox(height: 30,),

                SwitchListTile.adaptive(
                  value: product.available, 
                  title: const Text('Available'),
                  activeColor: Colors.indigo,
                  onChanged:  productForm.updateAvaliable,
                )
              ],
            ),
        )),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return  BoxDecoration( color: Colors.white, 
      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), 
      bottomRight: Radius.circular(20)), 
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05), 
          blurRadius: 10, 
          offset: const Offset(5, 5))
      ]
      );
  }
}