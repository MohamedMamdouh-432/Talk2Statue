import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk2statue/Authentication/bloc/login_cubit.dart';
import 'package:talk2statue/Authentication/bloc/login_states.dart';
import 'package:talk2statue/Authentication/presentation/widgets/login_widgets.dart';
import 'package:talk2statue/core/utilities/media_query_data.dart';

class SignUpPage extends StatefulWidget {
    static const String routeName = "/signuppage";
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: loginAppBar('Sign Up'),
      body: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state) {
          
        },
        builder: (BuildContext context, state) {
          var isChecked = LoginCubit.get(context).isChecked;
          return  SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                customFormField(hint: 'user name', icon: Icon(Icons.person)),
                customFormField(hint: 'E-mail', icon: Icon(Icons.email)),
                customFormField(hint: 'Password', icon: Icon(Icons.key,),obscureText: true),
                Row(
                  children: [
                    Checkbox(value: isChecked, onChanged: (bool? value){
                      LoginCubit.get(context).toggleCheckbox(value!);
                    }),
                    Text('Allow terms & conditions',style: TextStyle(fontSize: 16),)
                  ],
                ),
                customButton(buttonFunction: (){}, title: 'Sign Up'),
                Image.asset('assets/images/SignUpx.jpg',height:0.5*(context.height),)
              ],
            ),
          ),
        );
        },
      ),
    );
  }
}