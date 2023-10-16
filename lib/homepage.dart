import 'package:calculator_clone/history_page.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

enum Item { itemOne, itemTwo }

class CalculationHistory {
  static final List<String> calculationHistory = [];
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Parser p = Parser();
  final ContextModel cm = ContextModel();
  var userInput = '';
  var answer = '';
  bool isDarkMode = false;
  Color acButtonColor = Colors.black;
  Color plusMinusButtonColor = Colors.black;

  final List<String> buttons = [
    'AC',
    '+/-',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '00',
    '.',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData darkTheme = ThemeData.dark();

    if (isDarkMode) {
      acButtonColor = Colors.white;
      plusMinusButtonColor = Colors.white;
    } else {
      acButtonColor = Colors.black;
      plusMinusButtonColor = Colors.black;
    }

    return MaterialApp(
      theme: isDarkMode ? darkTheme : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: isDarkMode ? Colors.white : Colors.black,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
            icon: Icon(
              isDarkMode ? Icons.wb_sunny : Icons.nightlight,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          actions: [
            PopupMenuButton<Item>(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Item>>[
                PopupMenuItem<Item>(
                  value: Item.itemOne,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HistoryPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "History",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem<Item>(
                  value: Item.itemTwo,
                  child: GestureDetector(
                    onTap: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor:
                              isDarkMode ? Colors.white : Colors.black,
                          content: Row(
                            children: [
                              Text(
                                'Powered and developed by ',
                                style: TextStyle(
                                  color: isDarkMode ? Colors.black : Colors.white,
                                ),
                              ),
                              Text(
                                'Jagadish Poudel',
                                style: TextStyle(
                                  color: isDarkMode ? Colors.red : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    },
                    child: const Text(
                      "About",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              top: 50,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerRight,
                child: Text(
                  userInput,
                  style: TextStyle(
                    fontSize: 26,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 90,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDarkMode ? Colors.white60 : Colors.black54,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        answer,
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 170,
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < buttons.length) {
                      String buttonText = buttons[index];
                      Color? buttonColor = isOperator(buttonText)
                          ? Colors.orange
                          : (buttonText == 'AC' || buttonText == '+/-'
                              ? (buttonText == 'AC'
                                  ? acButtonColor
                                  : plusMinusButtonColor)
                              : Colors.blueGrey[600]);
                      return GestureDetector(
                        onTap: () {
                          onButtonPressed(buttonText);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: buttonColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              buttonText,
                              style: TextStyle(
                                color: isOperator(buttonText)
                                    ? Colors.white
                                    : isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isOperator(String text) {
    return ['+', '-', '*', '/', '%', '='].contains(text);
  }

  void onButtonPressed(String buttonText) {
    if (buttonText == 'AC') {
      setState(() {
        userInput = '';
        answer = '';
      });
    } else if (buttonText == '=') {
      setState(() {
        Expression exp = p.parse(userInput);
        answer = exp.evaluate(EvaluationType.REAL, cm).toString();
        CalculationHistory.calculationHistory.add('$userInput = $answer');
      });
    } else {
      setState(() {
        userInput += buttonText;
      });
    }
  }
}
