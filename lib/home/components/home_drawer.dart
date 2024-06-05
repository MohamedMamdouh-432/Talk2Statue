import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:talk2statue/core/utils/app_constants.dart';
import 'package:talk2statue/home/widgets/drawer_element.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 30,
      child: Column(
        children: [
          SizedBox(
            height: context.height * 0.48,
            child: UserAccountsDrawerHeader(
              accountName: const Text('Ahmed Amin'),
              accountEmail: const Text('ahmedamin@gmail.com'),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/profile_picture.jpeg'),
              ),
              currentAccountPictureSize: Size.square(200.h),
              decoration: const BoxDecoration(
                color: AppConstants.drawerColor,
              ),
            ),
          ),
          DrawerElement(
            iconData: Icons.favorite_border,
            text: 'Favourite Statues',
            onTap: () {},
          ),
          DrawerElement(
            iconData: Icons.logout_outlined,
            text: 'Logout',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
