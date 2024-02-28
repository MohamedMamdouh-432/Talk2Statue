import 'package:flutter/material.dart';
import 'package:talk2statue/Authentication/data/datasource/email_sign_in.dart';
import 'package:talk2statue/Authentication/data/datasource/google_sign_in.dart';
import 'package:talk2statue/Authentication/presentation/views/sign_up.dart';
import 'package:talk2statue/Authentication/presentation/views/test.dart';
import 'package:talk2statue/Authentication/presentation/widgets/login_widgets.dart';
import 'package:talk2statue/core/utilities/media_query_data.dart';

class SignInPage extends StatefulWidget {
  static const String routeName = "/signinpage";
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
      appBar: loginAppBar('Sign In'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
             Form(
              key:formState,
              child: Column(children: [
               customFormField(
                hint: 'E-mail',
                 icon: const Icon(Icons.email),
                 controller:emailController ),
              customFormField(
                  hint: 'Password',
                   icon: const Icon(Icons.key),
                   controller:passwordController ,
                    obscureText: true),
             ],)),
              const SizedBox(
                height: 20,
              ),
              customButton(title: 'Sign In', buttonFunction: ()async {
              var user=  await signIn(context: context,
              formState: formState,
                 emailAddress: emailController.text,
                  password: passwordController.text);
                  if(user!=null){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_){return Test();}), (route) => false);
                  }
              }),
              customTextButton(
                  title: 'Forget Password?', buttonFunction: () {}),
              ElevatedButton.icon(
                onPressed: ()async {
                  showLoading(context);
                  await signInWithGoogle();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_){return Test();}), (route) => false);
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
                      buttonFunction: (){
                        Navigator.pushNamed(context, SignUpPage.routeName);
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
