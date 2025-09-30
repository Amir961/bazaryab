import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/network/sharedPref_service.dart';
import '../../../../core/res/constant.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SharedPrefService sharedPrefService;
  SplashBloc(this.sharedPrefService) : super(SplashInitial()) {
    on<GetDataEvent>(_onGetDataEvent);
  }

  _onGetDataEvent(
      GetDataEvent event,
      Emitter<SplashState> emit,
      ) async {


    await Future.delayed(Duration(seconds: 2));


    final bool isLogin=  sharedPrefService.getBool(ISLOGINKEY)??false;
    final  token=  sharedPrefService.getString(TOKEN)??'';

    debugPrint('token_is:$token');



    if(isLogin) {
      emit(GotToMain());
    }
    else{
      emit(GotToLogin());
    }

    // try {
    //  // final responseJson= await apiService.post('login',queryParameters:{}  );
    //
    //   //  final List<City> list=  result['data'].map((json) => City.fromJson(json)).toList();
    //
    //   Future.delayed(Duration(seconds: 3));
    //
    //
    //
    //   emit(state.copyWith(statusButton: StatusButton.success));
    //
    //
    //
    // } on ConnectionException catch (e) {
    //   emit(state.copyWith(statusButton: StatusButton.noInternet));
    //
    // } on ApiException catch (e) {
    //   emit(state.copyWith(statusButton: StatusButton.failed,message: e.message));
    //
    // } catch (e) {
    //   emit(state.copyWith(statusButton: StatusButton.failed,message: e.toString()));
    //
    // }


  }
}
