import 'package:flutter/material.dart';

class SmallContainer extends StatelessWidget {
  const SmallContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xff514F4F)
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 9),
        child: Text('Action',style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 13,
          color: Color(0xffCBCBCB),
        ),),
      ),
    );
  }
}
