import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk2statue/conversation/presentation/bloc/conversation_bloc.dart';
import 'package:talk2statue/conversation/presentation/components/loading_indicator_component.dart';
import 'package:talk2statue/conversation/presentation/widgets/statue_record_button.dart';
import 'package:talk2statue/core/data/functions.dart';
import 'package:talk2statue/core/utilities/app_enums.dart';
import 'package:talk2statue/core/utilities/media_query_data.dart';
import 'package:talk2statue/home/bloc/home_cubit.dart';
import 'package:talk2statue/statue_recognition/bloc/statue_recognition_bloc.dart';

class ConversationViewBody extends StatelessWidget {
  const ConversationViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final imgFile = File(context.read<HomeCubit>().imagePath!);
    return BlocConsumer<StatueRecognitionBloc, StatueRecognitionState>(
      buildWhen: (prev, cur) => prev != cur,
      listenWhen: (prev, cur) => prev != cur,
      listener: (context, state) {
        if (state.requestState == RequestState.successful) {
          context.read<ConversationBloc>().add(
                ConversationStatuePreperationEvent(
                  statueName: state.statue.name,
                  statuePronounce:
                      state.statue.gender == 'male' ? 'his' : 'her',
                ),
              );
        } else if (state.requestState == RequestState.failure) {
          showMessage(
            context,
            'Oops ! ${state.message} \nTry Again after while 😅',
            DialogType.error,
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) => ConditionalBuilder(
        condition: state.requestState == RequestState.onProgress,
        builder: (_) => const ConversationLoadingIndicator(),
        fallback: (_) => ConditionalBuilder(
          condition: state.requestState == RequestState.failure,
          builder: (_) => const SizedBox(),
          fallback: (_) => ConditionalBuilder(
            condition: state.requestState == RequestState.successful,
            builder: (_) => Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: Image.file(
                    imgFile,
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    height: context.height * 0.6,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                const StatueRecordingButton(),
              ],
            ),
            fallback: (_) => const SizedBox(),
          ),
        ),
      ),
    );
  }
}
