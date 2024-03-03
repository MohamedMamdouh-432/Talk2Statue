import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk2statue/conversation/presentation/bloc/conversation_bloc.dart';
import 'package:talk2statue/conversation/presentation/components/loading_indicator_component.dart';
import 'package:talk2statue/conversation/presentation/widgets/recording_button.dart';
import 'package:talk2statue/core/presentation/views/error_view.dart';
import 'package:talk2statue/core/utilities/app_enums.dart';
import 'package:talk2statue/core/utilities/media_query_data.dart';
import 'package:talk2statue/home/bloc/home_cubit.dart';
import 'package:talk2statue/home/presentation/widgets/curved_appbar.dart';
import 'package:talk2statue/statue_recognition/bloc/statue_recognition_bloc.dart';
import 'package:talk2statue/statue_recognition/domain/entities/statue_parameter.dart';

class ConversationView extends StatefulWidget {
  static const String routeName = '/conversation';
  const ConversationView({super.key});
  @override
  State<ConversationView> createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView> {
  @override
  void initState() {
    super.initState();
    context.read<StatueRecognitionBloc>().add(
          StatueRecognitionEventRequested(
            StatueParams(context.read<HomeCubit>().imagePath!),
          ),
        );
  }

  @override
  void dispose() {
    super.dispose();
    context.read<ConversationBloc>().add(const ConversationDisposeEvent());
  }

  @override
  Widget build(BuildContext context) {
    final imgFile = File(context.read<HomeCubit>().imagePath!);
    return BlocListener<ConversationBloc, ConversationState>(
      listener: (context, state) {},
      child: BlocBuilder<StatueRecognitionBloc, StatueRecognitionState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: state.requestState == RequestState.successful
                ? Colors.white
                : Colors.grey,
            appBar: CurvedAppBar(
              preferredSize: Size.fromHeight(context.height * 0.14),
              head: state.requestState == RequestState.successful
                  ? state.statue.name
                  : null,
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
              child: ConditionalBuilder(
                condition: state.requestState == RequestState.onProgress,
                builder: (_) => const ConversationLoadingIndicator(),
                fallback: (_) => ConditionalBuilder(
                  condition: state.requestState == RequestState.failure,
                  builder: (_) => ErrorView(errorMessage: state.message),
                  fallback: (_) => ConditionalBuilder(
                    condition: state.requestState == RequestState.successful,
                    builder: (_) => Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          child: Image.file(
                            imgFile,
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.fitWidth,
                            width: double.infinity,
                            height: context.height * 0.65,
                          ),
                        ),
                        const RecordingButton(),
                      ],
                    ),
                    fallback: (_) => const SizedBox(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
