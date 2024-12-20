import 'package:flutter/material.dart';
import 'package:mimo/utils/responsive_helper.dart';
class CustomButton extends StatelessWidget {
  final String title;
  const CustomButton({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(width: double.infinity,height:50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.blue),child: Center(child: Text(title,style: TextStyle(fontSize:18,color: Colors.white,fontWeight: FontWeight.bold),)),);
  }
}