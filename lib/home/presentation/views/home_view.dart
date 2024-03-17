import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk2statue/core/utilities/app_constants.dart';
import 'package:talk2statue/core/utilities/media_query_data.dart';
import 'package:talk2statue/home/presentation/components/fav_statues_list.dart';
import 'package:talk2statue/home/presentation/components/meseum_introducer.dart';
import 'package:talk2statue/home/presentation/components/statue_talker.dart';
import 'package:talk2statue/home/presentation/widgets/curved_appbar.dart';
import 'package:talk2statue/home/presentation/widgets/drawer_element.dart';
import 'package:talk2statue/home/presentation/widgets/search_statue_bar.dart';

class HomeView extends StatelessWidget {
  static const String routeName = '/home';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(
        preferredSize: Size.fromHeight(context.height * 0.14),
        inHome: true,
        icon: Icons.menu,
      ),
      drawer: Drawer(
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome Visitor...',
                  textScaler: TextScaler.linear(1.8),
                ),
              ),
              SearchStatueBar(
                searchAction: () {},
              ),
              const FavStatuesList(),
              const SizedBox(height: 20),
              const MeseumIntroducerComponent(),
              const SizedBox(height: 20),
              const StatueTalkerComponent(),
            ],
          ),
        ),
      ),
    );
  }
}
