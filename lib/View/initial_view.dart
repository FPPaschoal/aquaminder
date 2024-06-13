import 'dart:async';

import 'package:flutter/material.dart';
import 'package:AquaMinder/Controller/waterInTakeController.dart';
import 'package:AquaMinder/Entidades/waterInTake.dart';
import 'package:AquaMinder/View/user_profile_view.dart';
import 'package:AquaMinder/View/weekly_graph_view.dart';

class InitialView extends StatefulWidget {
  const InitialView({Key? key}) : super(key: key);

  @override
  _InitialViewState createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  late StreamController<WaterIntake> _controller;
  late WaterIntake _waterIntakeData;

  @override
  void initState() {
    super.initState();
    _controller = StreamController<WaterIntake>();
    _fetchWaterIntakeData();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

void _fetchWaterIntakeData() async {
  try {
    final WaterIntake waterIntakeData = await waterInTakeController().buscar();
    _waterIntakeData = waterIntakeData;
    _controller.add(_waterIntakeData);
  } catch (e) {
    // Tratamento de erro, se necessário
    print('Erro ao carregar os dados de ingestão de água: $e');
  }
}
  void _addWater(int amount) {
    setState(() {
      _waterIntakeData.waterIntake += amount;
      if (_waterIntakeData.waterIntake >= _waterIntakeData.dailyGoal && !_waterIntakeData.congratulationsShown) {
        _showCongratulationsDialog();
        _waterIntakeData.congratulationsShown = true;
      }
      _controller.add(_waterIntakeData);
    });
  }

  void _removeWater(int amount) {
    setState(() {
      if (_waterIntakeData.waterIntake > 0) {
        _waterIntakeData.waterIntake -= amount;
        if (_waterIntakeData.waterIntake < 0) {
          _waterIntakeData.waterIntake = 0;
        }
      }
      if (_waterIntakeData.waterIntake < _waterIntakeData.dailyGoal) {
        _waterIntakeData.congratulationsShown = false;
      }
      _controller.add(_waterIntakeData);
    });
  }

  void _setDailyGoal(int goal) {
    setState(() {
      _waterIntakeData.dailyGoal = goal;
    });
    Navigator.of(context).pop();
    _controller.add(_waterIntakeData);
  }

  void _setFixedAmount(int amount) {
    setState(() {
      _waterIntakeData.fixedAmount = amount;
    });
    Navigator.of(context).pop();
    _controller.add(_waterIntakeData);
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Parabéns!'),
          content: const Text('Você atingiu sua meta diária de consumo de água!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showGoalDialog() {
    final TextEditingController goalController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Definir Meta Diária'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Digite a quantidade de água desejada (ml):'),
              const SizedBox(height: 10),
              TextField(
                controller: goalController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final int? goal = int.tryParse(goalController.text);
                if (goal != null && goal > 0) {
                  _setDailyGoal(goal);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, insira uma meta válida.'),
                    ),
                  );
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _showFixedAmountDialog() {
    final TextEditingController amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajustar Adicional Fixo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Digite o valor adicional fixo (ml):'),
              const SizedBox(height: 10),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final int? amount = int.tryParse(amountController.text);
                if (amount != null && amount > 0) {
                  _setFixedAmount(amount);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, insira um valor válido.'),
                    ),
                  );
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _showAddWaterDialog() {
    final TextEditingController amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Água'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Digite a quantidade de água para adicionar (ml):'),
              const SizedBox(height: 10),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final int? amount = int.tryParse(amountController.text);
                if (amount != null && amount > 0) {
                  _addWater(amount);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, insira uma quantidade válida.'),
                    ),
                  );
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToUserProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserProfileView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.exit_to_app,
            size: 30,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Sair'),
                  content: const Text('Tem certeza que deseja sair?'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Color(0xFF047ffb)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text(
                        'Sair',
                        style: TextStyle(color: Color.fromARGB(255, 251, 4, 4)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        title: const Text('AquaMinder'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              size: 30,
            ),
            onPressed: _navigateToUserProfile,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder<WaterIntake>(
          stream: _controller.stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao carregar os dados de consumo de água.'),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final waterIntakeData = snapshot.data!;

            double progress = waterIntakeData.waterIntake / waterIntakeData.dailyGoal;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Consumo de Água Diário',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 10,
                          backgroundColor: Colors.blue[100],
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                      Positioned(
                        child: Text(
                          '${waterIntakeData.waterIntake}/${waterIntakeData.dailyGoal} ml',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => _addWater(waterIntakeData.fixedAmount),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(100, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          '${waterIntakeData.fixedAmount} +',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 64),
                      ElevatedButton(
                        onPressed: () => _removeWater(waterIntakeData.fixedAmount),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(100, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          '${waterIntakeData.fixedAmount} -',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      ElevatedButton(
                        onPressed: _showFixedAmountDialog,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50),
                          backgroundColor: Colors.lightBlue[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          'Ajustar Adicional Fixo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _showGoalDialog,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50),
                          backgroundColor: Colors.lightBlue[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          'Editar Meta Diária',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WeeklyGraphView(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50),
                          backgroundColor: Colors.lightBlue[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          'Gráfico Semanal',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _showAddWaterDialog,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50),
                          backgroundColor: Colors.lightBlue[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          'Adicionar Água',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
