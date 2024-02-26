import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk2statue/Authentication/bloc/login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginIntialState());
   static LoginCubit get(context) {
    return BlocProvider.of(context);
  }
  bool isChecked = false;
  void toggleCheckbox(bool value){
     value=!value;
     emit(ToggleCheckboxState());
  }
}