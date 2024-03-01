import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk2statue/Authentication/bloc/login_cubit.dart';
import 'package:talk2statue/Authentication/bloc/login_states.dart';
import 'package:talk2statue/Authentication/data/datasource/email_sign_up.dart';
import 'package:talk2statue/Authentication/presentation/views/login.dart';
import 'package:talk2statue/Authentication/presentation/widgets/login_widgets.dart';
import 'package:talk2statue/core/utilities/app_constants.dart';
import 'package:talk2statue/core/utilities/media_query_data.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = "/signuppage";
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: loginAppBar('Sign Up'),
      body: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (BuildContext context, state) {
          final loginCubit = LoginCubit.get(context);
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Form(
                      key: AppConstants.formState,
                      child: Column(
                        children: [
                          customFormField(
                              hint: 'user name',
                              icon: const Icon(Icons.person)),
                          customFormField(
                              controller: emailController,
                              hint: 'E-mail',
                              icon: const Icon(Icons.email)),
                          customFormField(
                              controller: passwordController,
                              hint: 'Password',
                              icon: const Icon(
                                Icons.key,
                              ),
                              obscureText: true),
                        ],
                      )),
                  Row(
                    children: [
                      Checkbox(
                          value: loginCubit.isChecked,
                          onChanged: (_) {
                            loginCubit.toggleCheckbox();
                          }),
                      const Text(
                        'Allow terms & conditions',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  customButton(
                      buttonFunction: () async {
                        var user = await signUp(
                            context: context,
                            emailAddress: emailController.text,
                            password: passwordController.text);
                        if (user != null) {
                          Navigator.pushNamed(
                            context,
                            LoginPage.routeName,
                          );
                        }
                      },
                      title: 'Sign Up'),
                  Image.asset(
                    'assets/images/SignUpx.jpg',
                    height: 0.5 * (context.height),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
