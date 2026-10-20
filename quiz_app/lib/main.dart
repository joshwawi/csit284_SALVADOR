import 'package:flutter/material.dart';
import 'package:quiz_app/wallpaper.dart';


void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient:LinearGradient(colors: [
            const Color.fromARGB(255, 100, 11, 216), 
            const Color.fromARGB(255, 100, 11, 216)
          ])
        ), 
      child: Center(
        child: StartQuiz(),
        ),
      ),
    ),
  ),
  ); 
}