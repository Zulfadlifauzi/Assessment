import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class EmptyStateWidget extends StatelessWidget {
  final String? customText;
  const EmptyStateWidget({super.key, this.customText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const Icon(
          LineIcons.folderOpen,
          size: 50,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          customText.toString(),
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
