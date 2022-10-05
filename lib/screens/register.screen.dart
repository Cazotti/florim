import 'package:final_project/screens/login.screen.dart';
import 'package:flutter/material.dart';

import '../models/register.model.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = '/register';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RegisterModel registerModel = RegisterModel();

  RegisterScreen({Key? key}) : super(key: key);

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
                'Cadastro de Usuário',
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
                  usernameFormField(),
                  emailFormField(),
                  passwordFormField(),
                  confirmPasswordFormField(),
                  Row(children: [
                    const Text('Sexo: ', style: TextStyle(fontSize: 14)),
                    genderRadio(1), const Text("Masculino"),
                    genderRadio(2), const Text("Feminino"),
                  ]),
                  const Center(child: Divider(indent: 0)),
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
                    child: submitButton(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: GestureDetector(
                    onTap: () { Navigator.pushNamed(context, LoginScreen.routeName); },
                    child: const Text(
                      'Realize o login',
                      style: TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
            return "Insira um e-mail";
          }
        }
        return null;
      },
      onSaved: (String? inValue) {
        registerModel.email = inValue ?? '';
      },
      decoration: const InputDecoration(
        hintText: "user@domain.br",
        labelText: "E-mail",
      ),
    );
  }

  Widget usernameFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (String? inValue) {
        if (inValue != null) {
          if (inValue.isEmpty) {
            return "Insira um nome de usuário";
          }
        }
        return null;
      },
      onSaved: (String? inValue) {
        registerModel.username = inValue ?? '';
      },
      decoration: const InputDecoration(
        labelText: "Nome de usuário",
      ),
    );
  }

  Widget passwordFormField() {
    return TextFormField(
      obscureText: true,
      validator: (String? inValue) {
        if (inValue != null) {
          if (inValue.length < 6) {
            return "Mínimo de 6 letras";
          }
        }
        return null;
      },
      onSaved: (String? inValue) {
        registerModel.password = inValue ?? '';
      },
      decoration: const InputDecoration(
        labelText: 'Senha',
      ),
    );
  }

  Widget confirmPasswordFormField() {
    return TextFormField(
      obscureText: true,
      validator: (String? inValue) {
        if (inValue != null) {
          if (inValue != registerModel.password) {
            return "Senhas diferentes";
          }
        }
        return null;
      },
      onSaved: (String? inValue) {
        registerModel.password = inValue ?? '';
      },
      decoration: const InputDecoration(
        labelText: 'Confirmação de Senha',
      ),
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      child: const Text("Registre-se!"),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
        }
      },
    );
  }

  Widget genderRadio(int value) {
    return Radio(
      value: value,
      groupValue: registerModel.gender,
      onChanged: (int? inValue) {
        if (inValue != null) {
          registerModel.gender = inValue;
        }
      },
    );
  }
}
