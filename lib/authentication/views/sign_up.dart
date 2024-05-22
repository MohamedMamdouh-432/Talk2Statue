import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:talk2statue/authentication/cubit/login_cubit.dart';
import 'package:talk2statue/authentication/cubit/login_states.dart';
import 'package:talk2statue/authentication/data/email_sign_up.dart';
import 'package:talk2statue/authentication/widgets/login_widgets.dart';
import 'package:talk2statue/core/utils/route_manager.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = "/signuppage";
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (BuildContext context, state) {
          final loginCubit = LoginCubit.get(context);
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Form(
                      key: formState,
                      child: Column(
                        children: [
                          customFormField(
                              controller: userNameController,
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
                          formState: formState,
                          emailAddress: emailController.text,
                          password: passwordController.text,
                        );
                        if (user != null) {
                          Get.toNamed(RouteManager.signInRoute);
                        }
                      },
                      title: 'Sign Up'),
                  Image.asset(
                    'assets/images/SignUpx.jpg',
                    height: 0.5 * (context.height),
                    fit: BoxFit.fitWidth,
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
