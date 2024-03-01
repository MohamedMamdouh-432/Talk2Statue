import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MeseumIntroducerComponent extends StatelessWidget {
  const MeseumIntroducerComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
              child: Image.asset(
                'assets/images/MuseumHome.jpg',
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                // height: 150,
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
                      'Tell me about The Meuseum',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    'When you are in the museum, allow me to tell you about the history and heritage of this ancient place .',
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
