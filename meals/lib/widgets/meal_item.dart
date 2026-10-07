import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MealItem extends StatelessWidget{
  const Mealitem({super.key, required this.meal}); 
  final Meal meal; 

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder{
      itemBuilder
    }
   return Card(
    child: Stack(
      children: [
        FadeInImage(placeholder: MemoryImage(TransparentImage)
        image: NetworkImage(meal.imageUrl)
        ), 
        Positioned(
          bottom: 0, 
          right: 0, 
          left: 0, 
          child: Container(
            color: Colors.black54, 
          )
        )
        ), 
      ],
    ),
   )
  }
}