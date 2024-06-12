import 'package:flutter/material.dart';
import 'package:talk2statue/core/utils/app_constants.dart';
import 'package:talk2statue/home/widgets/fav_statue_card.dart';

class FavStatuesList extends StatelessWidget {
  const FavStatuesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.only(top: 5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppConstants.statueImages.length,
        itemBuilder: (_, index) => FavStatueCard(
          statueImage: AppConstants.statueImages[index],
        ),
      ),
    );
  }
}
