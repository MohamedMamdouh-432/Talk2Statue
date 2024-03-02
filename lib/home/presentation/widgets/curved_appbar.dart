import 'package:flutter/material.dart';
import 'package:talk2statue/core/utilities/app_constants.dart';
import 'package:talk2statue/home/presentation/views/statue_talker.dart';

class CurvedAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Color backgroundColor;
  final IconData icon;
  final bool inHome;

  const CurvedAppBar({
    Key? key,
    required this.preferredSize,
    this.backgroundColor = AppConstants.primaryColor,
    this.icon = Icons.arrow_back_ios_new_outlined,
    this.inHome = false,
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
            if (inHome)
              IconButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  StatueTalker.routeName,
                ),
                iconSize: 35,
                icon: const Icon(Icons.fit_screen_outlined),
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
