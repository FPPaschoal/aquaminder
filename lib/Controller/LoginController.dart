import 'dart:html';

import 'package:AquaMinder/View/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController {
  criarConta(context, nome, email, senha) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((resultado) {
      sucesso(context, 'Usuário criado com sucesso!');
      Navigator.pop(context);
    }).catchError((e) {
      switch (e.code) {
        case 'email-already-in-use':
          erro(context, 'O email já foi cadastrado.');
          break;
        default:
          erro(context, 'ERRO: ${e.code.toString()}');
      }
    });
  }

  Future<bool> login(BuildContext context, String email, String senha) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: senha);
      sucesso(context, 'Usuário autenticado com sucesso!');
      Navigator.pushNamed(context, 'principal');
      return true;
    } catch (e) {
      switch (e) {
        case 'invalid-credential':
          erro(context, 'Email e/ou senha inválida');
          break;
        case 'invalid-email':
          erro(context, 'O formato do email é inválido.');
          break;
        default:
          erro(context, 'ERRO: ${e.toString()}');
      }
      return false;
    }

    esqueceuSenha(context, String email) {
      if (email.isNotEmpty) {
        FirebaseAuth.instance.sendPasswordResetEmail(
          email: email,
        );
        sucesso(context, 'Email enviado com sucesso!');
      } else {
        erro(context, 'Não foi possível enviar o e-mail');
      }
    }

    logout() {
      FirebaseAuth.instance.signOut();
    }

    idUsuario() {
      return FirebaseAuth.instance.currentUser!.uid;
    }
  }
}
