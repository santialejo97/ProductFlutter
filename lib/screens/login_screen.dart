
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fl_productos/providers/login_form_provider.dart';
import 'package:fl_productos/screens/screens.dart';
import 'package:fl_productos/ui/input_decorations.dart';
import 'package:fl_productos/widgets/widgets.dart';


class LoginScreen extends StatelessWidget {
   
  const LoginScreen({Key? key}) : super(key: key);

  static String loginRoute = 'login';
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body:AuthBackgroundWidget(
      child: SingleChildScrollView(
        child:Column(
          children: [
           const  SizedBox(height: 250,),
            CardContainer(child: Column(children: [
              const  SizedBox(height: 10,),
              Text('Login', style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: 30,),
              
              ChangeNotifierProvider(
                create: (context) => LoginFormProvider(), 
                child: _LoginForm(),
              ),
              

            ],) ),
            const SizedBox(height: 50,),
            Text('Crear una nueva cuenta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            const SizedBox(height: 50,),
          ],) ,)
    )
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final loginProvider = Provider.of<LoginFormProvider>(context);


    return Container(
      child: Form(
        key: loginProvider.formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
        children: [
          
          TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorations.inputDecorations(
           hintText: 'Example@example.com', 
           labelText: 'Email', 
           helperText: 'Email del usuario', prefixIcon: Icons.email_outlined),
          onChanged: (value) => {loginProvider.email = value}, 
          validator: (value) {
            if(value == null) return 'Este campo es obligatorio';
            String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regExp  = RegExp(pattern);
            return !regExp.hasMatch(value) ? 'No es un correo valido': null;
          },
         ),


          TextFormField(
          autocorrect: false,
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecorations.inputDecorations(
            hintText: '********', 
            labelText: 'Password', 
            helperText: 'Password del usuario', prefixIcon: Icons.password_outlined),
          onChanged: (value) => { loginProvider.password = value}, 
          validator: (value) {
            
            if(value != null && value.length >= 8) return null;

            return 'Este campo es obligatorio y la contraseña tiene que ser de 8 caracteres';
            
          },
         ),


          const  SizedBox(height: 30,),

         MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 10,
          disabledColor: Colors.grey,
          color: Colors.purple,
          onPressed: loginProvider.isLoading?null: () async {
            FocusScope.of(context).unfocus();
            if (!loginProvider.isValidForm()) return;
            loginProvider.isLoading = true;
            await Future.delayed(const Duration(milliseconds: 2000));
            loginProvider.isLoading = false;
            Navigator.pushReplacementNamed(context, HomeScreen.homeRoute);
          },
          child: Container(
            padding:const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
            child:   Text(loginProvider.isLoading ?'Espere':'Iniciar Sesion', 
            style: const TextStyle(color: Colors.white, fontSize: 15),)),
         )


        ],
      )),
    );
  }
}