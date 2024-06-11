import 'package:flutter/material.dart';
import 'package:AquaMinder/simula_bd.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o AquaMinder'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AquaMinder - Controle seu Consumo de Água',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'O AquaMinder é um aplicativo desenvolvido para ajudar você a monitorar e gerenciar seu consumo diário de água de forma simples e eficiente. Com o AquaMinder, você pode registrar a quantidade de água consumida diariamente, definir metas e acompanhar seu progresso ao longo do tempo.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            Text(
              'Funcionalidades:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '• Registro diário do consumo de água\n• Definição de metas diárias\n• Acompanhamento do progresso\n• Estatísticas e gráficos de consumo',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(left: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Desenvolvido por:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Felipe de Paula Paschoal\nThalita Helena Lobo Fagundes da Paz',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AboutView(),
  ));
}
