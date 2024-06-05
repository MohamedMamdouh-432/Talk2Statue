import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk2statue/authentication/data/email_sign_in.dart';
import 'package:talk2statue/authentication/data/google_sign_in.dart';
import 'package:talk2statue/authentication/widgets/login_widgets.dart';
import 'package:talk2statue/core/utils/route_manager.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Form(
                  key: formState,
                  child: Column(
                    children: [
                      customFormField(
                          hint: 'E-mail',
                          icon: const Icon(Icons.email),
                          controller: emailController),
                      customFormField(
                          hint: 'Password',
                          icon: const Icon(Icons.key),
                          controller: passwordController,
                          obscureText: true),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              customButton(
                  title: 'Sign In',
                  buttonFunction: () async {
                    var user = await signIn(
                        context: context,
                        formState: formState,
                        emailAddress: emailController.text,
                        password: passwordController.text);
                    if (user != null) {
                      Get.toNamed(RouteManager.homeRoute);
                    }
                  }),
              customTextButton(
                  title: 'Forget Password?', buttonFunction: () {}),
              ElevatedButton.icon(
                onPressed: () async {
                  showLoading(context);
                  await signInWithGoogle();
                  Get.toNamed(RouteManager.homeRoute);
                },
                icon: Image.asset(
                  'assets/images/google.png',
                  height: 24,
                ),
                label: const Text('Sign In with Google'),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(75, 50),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an acoount?'),
                  customTextButton(
                      title: 'Sign Up',
                      buttonFunction: () {
                        Get.toNamed(RouteManager.signUpRoute);
                      })
                ],
              ),
              Image.asset(
                'assets/images/SignIn.jpg',
                height: (context.height) * 0.5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
