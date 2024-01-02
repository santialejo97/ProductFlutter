import 'package:fl_productos/screens/screens.dart';
import 'package:fl_productos/services/services.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp( AppState());

class AppState extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (context) => ProductService(),)
    ],
      child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.homeRoute,
      routes: {
        HomeScreen.homeRoute :(context) => const HomeScreen(),
        LoginScreen.loginRoute :(context) => const LoginScreen(),
        ProductScreen.productRouter:(context) => const ProductScreen()
      },
      theme: ThemeData.light().copyWith(
        floatingActionButtonTheme:const  FloatingActionButtonThemeData(
          backgroundColor: Colors.purple,
          elevation: 10,
          
          ),
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple, 
          elevation: 20, 
          shadowColor: Colors.purple)
      ),
    );
  }
}