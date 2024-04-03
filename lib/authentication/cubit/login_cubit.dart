import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk2statue/authentication/cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginIntialState());
   static LoginCubit get(context) {
    return BlocProvider.of(context);
  }
  bool isChecked = false;
  void toggleCheckbox(){
     isChecked=!isChecked;
     emit(ToggleCheckboxState());
  }
}