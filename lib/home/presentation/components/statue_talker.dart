import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatueTalkerComponent extends StatelessWidget {
  const StatueTalkerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 15,
        ),
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
                      height: 200,
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/images/onboarding2.jpg',
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 5, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Speak to The Statue',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'When you found statue you wish to talk to and have curiousity to know more about it\'s life, family, position, history and The events he witnessed.',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
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
