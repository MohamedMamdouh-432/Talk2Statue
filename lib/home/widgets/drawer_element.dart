import 'package:flutter/material.dart';

class DrawerElement extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Function() onTap;

  const DrawerElement({
    super.key,
    required this.iconData,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 212, 161, 7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(iconData),
            const SizedBox(width: 20),
            Text(
              text,
              textScaler: const TextScaler.linear(1.3),
            ),
          ],
        ),
      ),
    );
  }
}
