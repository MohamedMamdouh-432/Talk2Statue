import 'package:flutter/material.dart';
import 'package:talk2statue/core/data/dummy.dart';
import 'package:talk2statue/home/presentation/widgets/fav_statue_card.dart';

class FavStatuesList extends StatelessWidget {
  const FavStatuesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.only(top: 5, bottom: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: statueImages.length,
        itemBuilder: (_, index) => FavStatueCard(
          statueImage: statueImages[index],
        ),
      ),
    );
  }
}