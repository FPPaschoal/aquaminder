import 'package:AquaMinder/Entidades/waterInTake.dart';
import 'package:AquaMinder/View/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class waterInTakeController {
  void adicionar(context, WaterIntake waterIntake) {
    FirebaseFirestore.instance
        .collection('water')
        .add(waterIntake.toJson())
        .then(
          (value) => sucesso(context, ''),
        )
        .catchError(
          (onError) => erro(context, 'Erro $onError'),
        )
        .whenComplete(
          () => Navigator.of(context).pop(),
        );
  }

  
}
