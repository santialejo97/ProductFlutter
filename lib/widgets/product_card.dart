import 'package:fl_productos/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel product; 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
            margin: const EdgeInsets.only(top: 30, bottom: 50),
            width: double.infinity,
            height: 400,
            decoration: _CardBorders(),
            child:  Stack(
              alignment: Alignment.bottomLeft,
              children: [
                _BackgroundImage(picture: product.picture ?? '',),
                 _ProductDetails(name: product.name, id: product.id ?? '',),
                Positioned(
                  top: 0,
                  right: 0,
                  child: _PriceTag(price: product.price,),
                ),
                
                if(!product.available)
                const Positioned(
                  top: 0,
                  left: 0,
                  child: _NotAvaliable(),
                ),
              ],
            ),
          ),
    );
  }

  BoxDecoration _CardBorders() => BoxDecoration( 
    color: Colors.white, 
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(5, 5)
      )
    ]
    );
}

class _NotAvaliable extends StatelessWidget {
  const _NotAvaliable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration:   BoxDecoration(
        color: Colors.yellow[800],
        borderRadius:const  BorderRadius.only(bottomRight: Radius.circular(20), topLeft: Radius.circular(20))
      ),
      child:const  FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('No disponible', style: TextStyle(
            color: Colors.white, 
            fontSize: 20, 
            overflow: TextOverflow.ellipsis

            ),), 
        ),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  const _PriceTag({
    super.key, required this.price,
  });

  final double price; 

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 70,
      decoration: const BoxDecoration(color: Colors.indigo, 
      borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
      child:  FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const  EdgeInsets.symmetric(horizontal: 10),
          child:  Text('\$ $price', style:const  TextStyle(color: Colors.white, fontSize: 20),),
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({
    super.key, required this.name, required this.id,
  });

  final String name;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        decoration: _buildBoxDecoration(),
        height: 70,
        width: double.infinity,
        child:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( name, style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), maxLines: 2, overflow: TextOverflow.ellipsis,),
              Text('ID del producto: $id', style: const TextStyle(fontSize: 15, color: Colors.white), maxLines: 1,),
              
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
        color:Colors.indigo, 
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20))
      );
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({
    super.key, required this.picture,
  });

  final String picture;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Colors.purple,
        width: double.infinity,
        height: 400,
        child:picture == ''
        ? Image.asset('assets/no-image.png', fit: BoxFit.cover,)
        : FadeInImage(
          fit: BoxFit.cover,
          placeholder:const  AssetImage('assets/jar-loading.gif'), 
          image: NetworkImage(picture)),
      ),
    );
  }
}