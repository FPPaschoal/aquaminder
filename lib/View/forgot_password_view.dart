import 'package:flutter/material.dart';
import 'package:AquaMinder/simula_bd.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key});

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();

  bool emailValido = false;
  String? senha;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Senha'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20.0),
            const Text(
              'Informe o email da conta para Recuperar a senha',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                fillColor: Color.fromRGBO(227, 242, 253, 1),
                filled: true,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                senha = SimulaBD.recuperarSenha(_emailController.text);
                _enviarEmail(context);
              },
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
              child: const Text('Recuperar',
                  style: TextStyle(color: Color.fromRGBO(227, 242, 253, 1))),
            ),
          ],
        ),
      ),
    );
  }

  void _enviarEmail(BuildContext context) {
    SimulaBD.recuperarSenha(_emailController.text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Recuperação de Senha'),
          content: Text(senha == null
              ? 'Email não encontrado no banco de dados'
              : 'Senha: $senha'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text(
                'OK',
                style: TextStyle(color: Color.fromRGBO(227, 242, 253, 1)),
              ),
            ),
          ],
        );
      },
    );
  }
}
