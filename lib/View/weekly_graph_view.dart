import 'package:flutter/material.dart';

class WeeklyGraphView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = [5000, 3000, 4000, 2000, 5000, 6000, 4000];
    final labels = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab', 'Dom'];
    final labelsFull = [
      'Segunda',
      'Terça',
      'Quarta',
      'Quinta',
      'Sexta',
      'Sábado',
      'Domingo'
    ];

    final maxDataValue =
        data.reduce((value, element) => value > element ? value : element);
    final normalizedData = data.map((value) => value / maxDataValue).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Graph'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: normalizedData.map((value) {
                return Container(
                  height: value * 100,
                  width: 20,
                  color: Colors.blue,
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: labels.map((label) {
                return Text(label);
              }).toList(),
            ),
            const SizedBox(height: 16),
            Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                const TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Dia',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Água Tomada',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                for (int i = 0; i < labelsFull.length; i++)
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(labelsFull[i]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(data[i].toString() + ' ml'),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WeeklyGraphView(),
  ));
}
