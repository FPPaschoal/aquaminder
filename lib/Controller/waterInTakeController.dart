import 'package:AquaMinder/Controller/LoginController.dart';
import 'package:AquaMinder/Entidades/waterInTake.dart';
import 'package:AquaMinder/View/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class waterInTakeController {
  void adicionar(context, WaterIntake waterIntake) {
 FirebaseFirestore.instance
        .collection('water')
        .add(waterIntake.toJson())
        .then((resultado) => sucesso(context, 'dados adicionados com sucesso'))
        .catchError((e) => erro(context, 'Não foi possível adicionar os dados'))
        .whenComplete(() => Navigator.pop(context));
  }

Future<WaterIntake> buscar() async {
  final querySnapshot = await FirebaseFirestore.instance
    .collection('water')
    .where('userId', isEqualTo: LoginController().idUsuario())
    .get();

  if (querySnapshot.docs.isNotEmpty) {
    final doc = querySnapshot.docs.first;

    final data = doc.data();

    return WaterIntake(
      userId: LoginController().idUsuario(),
      waterIntake: data['waterIntake'],
      dailyGoal: data['dailyGoal'],
      fixedAmount: data['fixedAmount'],
      congratulationsShown: data['congratulationsShown'],
    );
  } else {
    throw Exception('Nenhum dado de ingestão de água encontrado para este usuário.');
  }
}


  void atualizarCampo(context, String campo, dynamic valor) {
    FirebaseFirestore.instance
        .collection('tarefas')
        .doc(LoginController().idUsuario())
        .update({campo: valor})
        .then((resultado) => sucesso(context, 'Campo atualizado com sucesso'))
        .catchError((e) => erro(context, 'Não foi possível atualizar o campo'))
        .whenComplete(() => Navigator.pop(context));
  }
}
