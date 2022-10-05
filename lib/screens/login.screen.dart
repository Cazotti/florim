import 'package:final_project/screens/home-page.screen.dart';
import 'package:final_project/screens/register.screen.dart';
import 'package:flutter/material.dart';

import '../models/login.model.dart';

//https://www.youtube.com/watch?v=c7luIVEIjSM

class LoginScreen extends StatelessWidget {
  static String routeName = '/login';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final LoginModel loginModel = LoginModel();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 20),
              child: Text(
                'Acessar Conta',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child: Column(
                children: [
                  emailFormField(),
                  passwordFormField(),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    width: 280,
                    height: 35,
                    child: submitButton(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: GestureDetector(
                    onTap: () { Navigator.pushNamed(context, RegisterScreen.routeName); },
                    child: const Text(
                      'Fazer cadastro',
                      style: TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget emailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (String? inValue) {
        if (inValue != null) {
          if (inValue.isEmpty) {
            return "Insira seu e-mail";
          }
        }
        return null;
      },
      onSaved: (String? inValue) {
        loginModel.email = inValue ?? '';
      },
      decoration: const InputDecoration(
        hintText: 'Seu E-mail',
        labelText: 'Insira seu E-mail',
      ),
    );
  }

  Widget passwordFormField() {
    return TextFormField(
      obscureText: true,
      validator: (String? inValue) {
        if (inValue != null) {
          return "Insira sua Senha";
        }
        return null;
      },
      onSaved: (String? inValue) {
        loginModel.password = inValue ?? '';
      },
      decoration: const InputDecoration(
        hintText: 'Sua senha',
        labelText: 'Digite sua senha',
      ),
    );
  }

  Widget submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
          Navigator.pushNamed(context, HomePageScreen.routeName);
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
        }
      },
      child: const Text('Entrar'),
    );
  }
}
