import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController =
      TextEditingController();

  bool _nomeValido = true;
  bool _emailValido = true;
  bool _senhaValida = true;
  bool _confirmarSenhaValida = true;
  bool _senhaCorrespondem = true;

  void _criarConta() {
    setState(() {
      _nomeValido = _nomeController.text.isNotEmpty;
      _emailValido = _emailController.text.isNotEmpty;
      _senhaValida = _senhaController.text.isNotEmpty;
      _confirmarSenhaValida = _confirmarSenhaController.text.isNotEmpty;
      _senhaCorrespondem =
          _senhaController.text == _confirmarSenhaController.text;
    });

    if (_nomeValido &&
        _emailValido &&
        _senhaValida &&
        _confirmarSenhaValida &&
        _senhaCorrespondem) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conta criada com sucesso!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _nomeController,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        errorText: _nomeValido ? null : 'Preencha o campo nome',
                        contentPadding: const EdgeInsets.all(10),
                        border: InputBorder.none,
                        prefixIcon: const Icon(Icons.person),
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
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        errorText:
                            _emailValido ? null : 'Preencha o campo email',
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
                        errorText:
                            _senhaValida ? null : 'Preencha o campo senha',
                        contentPadding: const EdgeInsets.all(10),
                        border: InputBorder.none,
                        prefixIcon: const Icon(Icons.lock),
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
                      controller: _confirmarSenhaController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirmar Senha',
                        errorText: _confirmarSenhaValida
                            ? (_senhaCorrespondem
                                ? null
                                : 'As senhas não correspondem')
                            : 'Preencha o campo confirmar senha',
                        contentPadding: const EdgeInsets.all(10),
                        border: InputBorder.none,
                        prefixIcon: const Icon(Icons.lock),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _criarConta,
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
                'Criar Conta',
                style: TextStyle(color: Color.fromRGBO(227, 242, 253, 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
