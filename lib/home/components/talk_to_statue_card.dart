import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talk2statue/core/utils/media_query_provider.dart';
import 'package:talk2statue/home/views/talk_to_statue_view.dart';

class TalkToStatueCard extends StatelessWidget {
  const TalkToStatueCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        TalkToStatueView.routeName,
      ),
      child: Container(
        width: context.width * 0.8,
        height: 280.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            width: 0.5,
            color: Colors.black54,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/scanstatue.jpg',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      height: 200.h,
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/images/onboarding2.jpg',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      height: 200.h,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
                left: 15,
                right: 5,
                bottom: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Speak to The Statue',
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    'When you found statue you wish to talk to and have curiousity to know more about it\'s life, family, position, history and The events he witnessed.',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.lato(
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
