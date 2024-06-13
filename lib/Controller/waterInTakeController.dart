import 'package:AquaMinder/Controller/LoginController.dart';
import 'package:AquaMinder/Entidades/waterInTake.dart';
import 'package:AquaMinder/View/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class waterInTakeController {
  bool adicionar(context, WaterIntake waterIntake) {
    try {
      FirebaseFirestore.instance.collection('water').add(waterIntake.toJson());
      sucesso(context, '');
      return true;
    } catch (onError) {
      erro(context, 'Erro $onError');
      return false;
    } finally {
      Navigator.of(context).pop();
    }
  }

Future<WaterIntake> buscar() async {
  // Obtém a referência para a coleção 'water' filtrada pelo userId
  final querySnapshot = await FirebaseFirestore.instance
    .collection('water')
    .where('userId', isEqualTo: LoginController().idUsuario())
    .get();

  // Verifica se há documentos retornados pela consulta
  if (querySnapshot.docs.isNotEmpty) {
    // Obtém o primeiro documento (assumindo que há apenas um documento por userId)
    final doc = querySnapshot.docs.first;

    // Extrai os dados do documento
    final data = doc.data();

    // Constrói um objeto WaterIntake com os dados obtidos
    return WaterIntake(
      userId: LoginController().idUsuario(),
      waterIntake: data['waterIntake'],
      dailyGoal: data['dailyGoal'],
      fixedAmount: data['fixedAmount'],
      congratulationsShown: data['congratulationsShown'],
    );
  } else {
    // Caso não encontre nenhum documento (situação de erro ou não há dados ainda)
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
