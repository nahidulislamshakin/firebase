import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget{

  final VoidCallback onTap;
  final title;
  final bool loading;

  RoundButton({required this.title, required this.onTap, this.loading = false});

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
        child: Center(child: loading ? CircularProgressIndicator(color: Colors.white,strokeWidth: 3,) : Text(title,style: TextStyle(color: Colors.white),)),
      ),
    );
  }

}