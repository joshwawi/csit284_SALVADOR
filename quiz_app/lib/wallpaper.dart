import 'package:flutter/material.dart'; 
import 'dart:math'; 
class StartQuiz extends StatefulWidget{
  const StartQuiz({super.key}); 

  @override
  State<StartQuiz> createState() {
    return _DiceRollerState(); 


  }
}

class _DiceRollerState extends State<StartQuiz> {
  final randomizer = Random(); 
  var currentDiceImage = 'assets/logo.png'; 
void startQuiz() {
  setState(() {
    var num = randomizer.nextInt(6) + 1; 
     currentDiceImage = 'assets/logo.png';
  currentDiceImage = 'assets/logo.png';
});
}

 @override
  Widget build(context) {
     return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              width: 315,
              currentDiceImage
              ),
            SizedBox(height: 100),             TextButton(
              onPressed: startQuiz,
             child: Text(
              style: TextStyle(fontSize: 28, color: Colors.white),"Start Quiz"),
              ),
            ],
          );
}
}