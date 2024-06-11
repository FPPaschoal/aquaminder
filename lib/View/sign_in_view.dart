import 'package:flutter/material.dart';
import 'package:AquaMinder/View/initial_view.dart';
import 'package:AquaMinder/View/forgot_password_view.dart';
import 'package:AquaMinder/View/about_view.dart';
import 'package:AquaMinder/View/sign_up_view.dart';
import 'package:AquaMinder/simula_bd.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  bool _emailValido = true;
  bool _senhaValida = true;
  bool _loginValido = true;

  void _login() {
    if (_emailController.text.isEmpty || _senhaController.text.isEmpty) {
      setState(() {
        _emailValido = _emailController.text.isNotEmpty;
        _senhaValida = _senhaController.text.isNotEmpty;
      });
      return;
    }

    if (SimulaBD.login(_emailController.text, _senhaController.text)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InitialView()),
      );
    } else {
      setState(() {
        _loginValido = false;
      });
    }
  }

  void _navegateSobre(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutView()),
    );
  }

  void _recuperarSenha() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordView()),
    );
  }

  void _criarConta() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AquaMinder'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(
                Icons.info,
                size: 30,
              ),
              onPressed: () => _navegateSobre(context),
              color: const Color(0xFF047ffb),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 0),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: _emailValido ? null : 'Preencha o campo email',
                  contentPadding: const EdgeInsets.all(10),
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  errorText: _senhaValida ? null : 'Preencha o campo senha',
                  contentPadding: const EdgeInsets.all(10),
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _recuperarSenha,
                child: const Text(
                  'Recuperar Senha',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color(0xFF047FFB),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (!_loginValido)
              const Text(
                'Email ou senha incorretos',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: _login,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const Color(0xFF047ffb);
                  } else if (states.contains(MaterialState.hovered)) {
                    return const Color(0xFF0a93ff);
                  } else {
                    return const Color(0xFF22b0ff);
                  }
                }),
                minimumSize:
                    MaterialStateProperty.all(const Size(double.infinity, 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: const Text(
                'Entrar',
                style: TextStyle(color: Color.fromRGBO(227, 242, 253, 1)),
              ),
            ),
            const SizedBox(height: 14),
            OutlinedButton(
              onPressed: _criarConta,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Color(0xFF047ffb)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'Criar Conta',
                style: TextStyle(color: Color(0xFF047ffb)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
