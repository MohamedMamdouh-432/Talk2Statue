import 'package:flutter/material.dart';
import 'package:talk2statue/core/utils/media_query_provider.dart';
import 'package:talk2statue/home/components/fav_statues_list.dart';
import 'package:talk2statue/home/components/home_drawer.dart';
import 'package:talk2statue/home/components/introduce_museum_card.dart';
import 'package:talk2statue/home/components/talk_to_statue_card.dart';
import 'package:talk2statue/shared/widgets/curved_appbar.dart';
import 'package:talk2statue/home/widgets/search_statue_bar.dart';

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
      drawer: const HomeDrawer(),
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
              const IntroduceMuseumCard(),
              const SizedBox(height: 20),
              const TalkToStatueCard(),
            ],
          ),
        ),
      ),
    );
  }
}
