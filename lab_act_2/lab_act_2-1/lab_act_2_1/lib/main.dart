import 'package:flutter/material.dart';
import 'package:lab_act_2_1/dice_roll.dart';

  var currentDiceImage = 'assets/dice-images/dice-images/dice-2.png'; 
void rollDice() {
     currentDiceImage = 'assets/dice-images/dice-4.png';
  currentDiceImage = 'assets/dice-images/dice-images/dice-$num.png';
}


void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient:LinearGradient(colors: [
            Colors.red, 
            Colors.yellow
          ])
        ), 
      child: Center(
        child: DiceRoller(),
        ),
      ),
    ),
  ),
  ); 
}