import 'package:flutter/material.dart';
import 'package:talk2statue/core/utilities/app_constants.dart';

class CurvedAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Color backgroundColor;

  const CurvedAppBar({
    Key? key,
    this.backgroundColor = AppConstants.primaryColor,
    required this.preferredSize,
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
              iconSize: 30,
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
            IconButton(
              onPressed: () {},
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
