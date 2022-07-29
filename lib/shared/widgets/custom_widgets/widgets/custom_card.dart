import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  CustomCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 2.0,
        shadowColor: Colors.grey,
        borderOnForeground: true,
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: child,
        ),
      ),
    );
  }
}
