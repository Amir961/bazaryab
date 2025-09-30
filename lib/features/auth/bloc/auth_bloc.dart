import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


import '../../../../core/utils/values.dart';
import '../../../core/network/api_service.dart';
import '../../../core/network/sharedPref_service.dart';
import '../../../core/res/constant.dart';
import '../../../core/utils/enum.dart';
import '../model/user_model.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  

  final ApiService  apiService;
  final SharedPrefService  sharedPrefService;

    AuthBloc(this.apiService,this.sharedPrefService) : super(AuthState(userName: '', password: '', statusButton: StatusButton.none, message: '')) {

    on<LoginEvent>(_onLoginEvent);
    on<ChangeUserNameEvent>(_onChangeUserNameEvent);
    on<ChangePasswordEvent>(_onChangePasswordEvent);

  }


  _onChangeUserNameEvent(
      ChangeUserNameEvent event,
      Emitter<AuthState> emit,
      ) async {

    emit(state.copyWith(userName:event.userName));
  }

  _onChangePasswordEvent(
      ChangePasswordEvent event,
      Emitter<AuthState> emit,
      ) async {

    emit(state.copyWith(password:event.password));
  }




  _onLoginEvent(
      LoginEvent event,
      Emitter<AuthState> emit,
      ) async {

    emit(state.copyWith(statusButton: StatusButton.loading));

    try {
      final responseJson= await apiService.post('signin',queryParameters:{"username":state.userName,
        "password":state.password,
        "device_token":"55666"}  );

        final user =   User.fromJson(responseJson['data']['user']);

     await sharedPrefService.setObject(USERDATA, user.toJson());
     final token=responseJson['data']['token'];
     debugPrint('token_is: $token');
     await sharedPrefService.setString(TOKEN, token);
     await sharedPrefService.setBool(ISLOGINKEY, true);
     await sharedPrefService.setInt(ISONLINE, user.isOnline??0);
      apiService.setToken(token);





      emit(state.copyWith(statusButton: StatusButton.success));



    } on ConnectionException catch (e) {
      debugPrint('error_is: ${e.toString()}');
      emit(state.copyWith(statusButton: StatusButton.noInternet));

    } on ApiException catch (e) {
      debugPrint('error_is: ${e.toString()}');
      emit(state.copyWith(statusButton: StatusButton.failed,message: e.message));

    } catch (e) {
      emit(state.copyWith(statusButton: StatusButton.failed,message: e.toString()));

    }


  }





}
