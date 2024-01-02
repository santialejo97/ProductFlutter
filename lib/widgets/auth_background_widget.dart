import 'package:flutter/material.dart';

class AuthBackgroundWidget extends StatelessWidget {
   
  const AuthBackgroundWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    return   SizedBox( 
      width: double.infinity,
      height:double.infinity, 
      child:   Stack(
        children: [
          const  _OragenBox(), 

          const _HeaderIcon(),

          child
           
        ]
        ),);
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(top: true,
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        width: double.infinity, 
        child:const  Icon(Icons.person_pin, color: Colors.white, size: 100,),),
    );
  }
}

class _OragenBox extends StatelessWidget {
  const _OragenBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _OragenBackground(), 
      child:const Stack(children: [
        Positioned(top: 90, left: 40,child: _Bubble(),)   ,
        Positioned(top: -30,  right: 30,child: _Bubble(),)   ,
        Positioned(bottom: -50, right: 50,child: _Bubble(),)   ,
        Positioned(bottom: 70, right: -40,child: _Bubble(),)   ,
        Positioned(bottom: -40, left: 70,child: _Bubble(),)   ,
      ]) ,);
  }

  BoxDecoration _OragenBackground() =>  const BoxDecoration(
    gradient: LinearGradient(colors: [
      Color.fromRGBO(63, 63, 156, 1),
      Color.fromRGBO(90, 70, 178, 1)
    ])
  );
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100), 
        color: const Color.fromRGBO(255, 255, 255, 0.05), ),
    );
  }
}