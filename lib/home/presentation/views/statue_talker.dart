import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talk2statue/core/utilities/media_query_data.dart';
import 'package:talk2statue/home/bloc/home_cubit.dart';
import 'package:talk2statue/home/bloc/home_states.dart';
import 'package:talk2statue/home/presentation/views/test.dart';
import 'package:talk2statue/home/presentation/widgets/curved_home_appbar.dart';

class StatueTalker extends StatelessWidget {
  static const String routeName = '/statuetaker';
  const StatueTalker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CurvedAppBar(preferredSize: Size.fromHeight(context.height * 0.14)),
      body: BlocConsumer<HomeCubit,HomeStates>(
        listener: (BuildContext context, HomeStates state) {  },
        builder: (BuildContext context, HomeStates state) {
          var cubit = HomeCubit.get(context); 
          return SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/onboarding3.png',
                height: (context.height) * 0.35,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Speak To Statue',
                      style:
                          TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'When you found statue you wish to talk to and have curiousity to know more about it\'s life, family, position, history and The events he witnessed.',
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async{
                      await cubit.selectImageFromCamera(ImageSource.camera);
                    },
                    icon: Icon(Icons.camera),
                    label: Text('Scan Statue'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await cubit.selectImageFromCamera(ImageSource.gallery);
                    },
                    icon: Icon(Icons.photo),
                    label: Text('From Gallery'),
                  ),
                ],
              ),
              SizedBox(height: 20),
                if (cubit.imageName!=null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Image: ${cubit.imageName}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 200.w,
                height: 60.h,
                child: ElevatedButton(
                  onPressed: () {
                    (cubit.imageName!=null)?Navigator.push(context, MaterialPageRoute(builder: (_)=>Test())) :null;
                  },
                  style: ElevatedButton.styleFrom(),
                  child: Text(
                    'Start',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ),
              ),
            ],
          ),
        );
         },
      ),
    );
  }
}
