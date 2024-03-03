import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk2statue/conversation/presentation/widgets/recording_button.dart';
import 'package:talk2statue/core/utilities/media_query_data.dart';
import 'package:talk2statue/home/bloc/home_cubit.dart';
import 'package:talk2statue/home/presentation/widgets/curved_appbar.dart';

class ConversationPage extends StatelessWidget {
  static const String routeName = '/conversation';
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final imgFile = File(context.read<HomeCubit>().imagePath!);
    return Scaffold(
      appBar: CurvedAppBar(
        preferredSize: Size.fromHeight(context.height * 0.14),
        head: 'Ramsis III',
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: Image.file(
                imgFile,
                filterQuality: FilterQuality.high,
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ),
            const RecordingButton(),
          ],
        ),
      ),
    );
  }
}
