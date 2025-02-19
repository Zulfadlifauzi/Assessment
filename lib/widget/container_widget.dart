import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  final String customText;
  const ContainerWidget({super.key, required this.customText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 0,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(20)),
      child: Text(
        customText.toString(),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
