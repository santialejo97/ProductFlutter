import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
   
  const CardContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity, 
        decoration:  _CardDecoration(),
        child: child,
      ),
    );
  }

  BoxDecoration _CardDecoration() => BoxDecoration(
    color: Colors.white, 
    borderRadius: BorderRadius.circular(10),
    boxShadow: const [
       BoxShadow(
        color: Colors.black12,
        blurRadius: 15,
        offset: Offset(0, 5)
      )
    ]
    );
}