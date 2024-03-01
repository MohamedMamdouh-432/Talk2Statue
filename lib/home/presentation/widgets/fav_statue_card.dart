import 'package:flutter/material.dart';

class FavStatueCard extends StatelessWidget {
  final String statueImage;
  const FavStatueCard({
    super.key,
    required this.statueImage,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Image.asset(
        statueImage,
        filterQuality: FilterQuality.high,
        fit: BoxFit.fill,
      ),
    );
  }
}
