import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
   
  const ProductImage({Key? key,  required this.picture}) : super(key: key);

  final String? picture;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20 , right: 20),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 450,
        child:  Opacity(
          opacity: 0.8,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), 
              topLeft: Radius.circular(20)),
            child: picture == ''
              ? Image.asset('assets/no-image.png', fit: BoxFit.cover,)
              :  FadeInImage(
              fit: BoxFit.cover,
              placeholder: const AssetImage('assets/jar-loading.gif'), 
              image: NetworkImage(picture!)),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    boxShadow: [
      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(5, 5))
    ],
    color: Colors.grey,
    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
  );
}