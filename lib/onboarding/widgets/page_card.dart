import 'package:flutter/material.dart';
import 'package:talk2statue/core/utilities/media_query_data.dart';
import 'package:talk2statue/onboarding/models/pagedata.dart';

class PageCard extends StatelessWidget {
  final PageData pdata;
  const PageCard({
    super.key,
    required this.pdata,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            pdata.imgPath,
            width: double.infinity,
            fit: BoxFit.fitWidth,
            height: context.height * 0.45,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              pdata.title,
              textScaler: const TextScaler.linear(2),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              pdata.desc,
              textScaler: const TextScaler.linear(1.15),
              textAlign: TextAlign.center,
              style: const TextStyle(
                height: 1.5,
                fontWeight: FontWeight.w300,
                color: Colors.black54,
              ),
            ),
          ],
        )
      ],
    );
  }
}
