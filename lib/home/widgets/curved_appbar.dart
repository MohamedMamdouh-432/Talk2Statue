import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talk2statue/core/utils/app_constants.dart';
import 'package:talk2statue/statue_recognition/views/talk_to_statue_view.dart';

class CurvedAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Color backgroundColor;
  final IconData icon;
  final bool inHome;
  final String? head;

  const CurvedAppBar({
    Key? key,
    required this.preferredSize,
    this.backgroundColor = AppConstants.primaryColor,
    this.icon = Icons.arrow_back_ios_new_outlined,
    this.inHome = false,
    this.head,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CurvedAppBarPainter(backgroundColor),
      child: Container(
        height: preferredSize.height,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => inHome
                  ? Scaffold.of(context).openDrawer()
                  : Navigator.pop(context),
              iconSize: 30,
              icon: Icon(icon),
            ),
            ConditionalBuilder(
              condition: head != null,
              builder: (context) => Text(
                head!,
                style: GoogleFonts.lato(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              fallback: (context) => const SizedBox(),
            ),
            ConditionalBuilder(
              condition: inHome,
              builder: (context) => IconButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  TalkToStatueView.routeName,
                ),
                iconSize: 35,
                icon: const Icon(Icons.fit_screen_outlined),
              ),
              fallback: (context) => const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurvedAppBarPainter extends CustomPainter {
  final Color backgroundColor;
  _CurvedAppBarPainter(this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = backgroundColor;

    var path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 30)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 25)
      ..lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CurvedAppBarPainter oldDelegate) =>
      oldDelegate.backgroundColor != backgroundColor;
}
