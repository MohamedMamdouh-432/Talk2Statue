import 'package:flutter/material.dart';
import 'package:talk2statue/core/utilities/media_query_data.dart';
import 'package:talk2statue/home/presentation/components/fav_statues_list.dart';
import 'package:talk2statue/home/presentation/components/meseum_introducer.dart';
import 'package:talk2statue/home/presentation/components/statue_talker.dart';
import 'package:talk2statue/home/presentation/widgets/curved_home_appbar.dart';
import 'package:talk2statue/home/presentation/widgets/search_statue_bar.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(
        preferredSize: Size.fromHeight(context.height * 0.14),
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
              const MeseumIntroducerComponent(),
              const StatueTalkerComponent(),
            ],
          ),
        ),
      ),
    );
  }
}
