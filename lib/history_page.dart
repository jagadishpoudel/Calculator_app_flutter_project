import 'package:calculator_clone/homepage.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculation History'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.blueGrey[600],
      ),
      body: ListView.builder(
        itemCount: CalculationHistory.calculationHistory.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        CalculationHistory.calculationHistory[index],
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _deleteHistoryEntry(index);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 1,
              ),
            ],
          );
        },
      ),
    );
  }

  void _deleteHistoryEntry(int index) {
    setState(() {
      CalculationHistory.calculationHistory.removeAt(index);
    });
  }
}
