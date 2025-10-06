import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fare/core/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/network/sharedPref_service.dart';
import '../../../../core/res/constant.dart';
import '../../../../core/utils/constants.dart';
import '../models/common_setting.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final ApiService apiService;
  final SharedPrefService sharedPrefService;
  SplashBloc(this.sharedPrefService,this.apiService) : super(SplashInitial(dataApp: null)) {
    on<GetDataEvent>(_onGetDataEvent);
  }

  _onGetDataEvent(
      GetDataEvent event,
      Emitter<SplashState> emit,
      ) async {




    try {
      final result = await apiService.get('common');

      DataApp  dataApp = DataApp.fromJson( result['data']);

      final bool isLogin=  sharedPrefService.getBool(ISLOGINKEY)??false;

      if(isLogin)
        {
          final  token=  sharedPrefService.getString(TOKEN)??'';
          debugPrint('token_is: $token');
          apiService.setToken(token);
          emit(GoToMain(dataApp: dataApp));
        }
      else
        {
          emit(GoToLogin(dataApp: dataApp));
        }





    }
    on ConnectionException catch (e) {
      debugPrint('error_is: ${e.toString()}');
      emit(NoNetWork(dataApp: null));

    } on ApiException catch (e) {
      debugPrint('error_is: ${e.toString()}');
      emit(ErrorNetwork(dataApp: null,message: e.message));

    } catch (e) {
      emit(ErrorNetwork(dataApp: null,message: e.toString()));
    }
   // catch(ex) {
    //   final user = await getUserFromPrefs();
    //
    //   if (user == null) {
    //     return emit(SplashGoIntro());
    //   }
    //   else {
    //     userToken = user.token ?? '';
    //     debugPrint('token_is: ${user.token}');
    //     debugPrint('user_is: $user');
    //     // context.go(AuthenticationScreen.routeName);
    //     return emit(SplashGoHome());
    //   }
    // }




    // await Future.delayed(Duration(seconds: 2));
    //
    //
    // final bool isLogin=  sharedPrefService.getBool(ISLOGINKEY)??false;
    // final  token=  sharedPrefService.getString(TOKEN)??'';
    //
    // debugPrint('token_is:$token');
    //
    //
    //
    // if(isLogin) {
    //   emit(GoToMain());
    // }
    // else{
    //   emit(GoToLogin());
    // }

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
