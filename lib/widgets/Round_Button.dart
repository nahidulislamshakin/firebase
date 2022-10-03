import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget{

  final VoidCallback onTap;
  final title;

  RoundButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(child: Text(title,style: TextStyle(color: Colors.white),)),
      ),
    );
  }

}