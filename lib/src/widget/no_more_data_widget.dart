import 'package:flutter/material.dart';

class NoMoreDataWidget extends StatelessWidget {
  final String? customText;
  const NoMoreDataWidget({
    super.key,
    this.customText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          customText.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
