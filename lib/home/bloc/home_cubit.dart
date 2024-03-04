import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talk2statue/core/data/functions.dart';
import 'package:talk2statue/home/bloc/home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeIntialState());
  static HomeCubit get(context) {
    return BlocProvider.of(context);
  }

  String? imageName, imagePath;
  Future<void> selectImageFromCamera(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      imageName = extractFileName(pickedImage.path);
      imagePath = await saveFileLocally(pickedImage.path);
      emit(ImageSelectionState());
    }
  }
}
