import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:talk2statue/home/bloc/home_states.dart';

class HomeCubit extends Cubit<HomeStates>{
 HomeCubit():super(HomeIntialState());
   static HomeCubit get(context) {
    return BlocProvider.of(context);
  }
  var pickedImage;
  var imageName;
  String? imagePath;
  Future<void> selectImageFromCamera(ImageSource source) async {
     pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      imageName  = extractFileName(pickedImage.path);
      await saveImage(pickedImage.path);
      emit(ImageSelectionState());
    }
  }
  String extractFileName(String filePath) {
    final file = File(filePath);
    return file.path.split('/').last;
  }
   Future<void> saveImage(String filePath) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final String appDirPath = appDir.path;
    final String fileName = filePath.split('/').last;
    imagePath = '$appDirPath/$fileName';

    final File newImage = File(filePath);
    await newImage.copy(imagePath!);
    print('Image saved at: $imagePath');
  }
}