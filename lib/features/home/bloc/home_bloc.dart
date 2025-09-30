import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fare/core/network/api_service.dart';
import 'package:fare/core/utils/enum.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/network/sharedPref_service.dart';
import '../../../core/res/constant.dart';
import '../../auth/model/user_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SharedPrefService sharedPrefService;
  final ApiService apiService;
  HomeBloc(this.sharedPrefService,this.apiService) : super(HomeState(user: sharedPrefService.getObject<User>(USERDATA,(map) => User.fromJson(map),), message: '', statusButton: StatusButton.none, isOnline: sharedPrefService.getInt(ISONLINE)??0,)) {

    on<ChangeOnline>(_onChangeOnline);
  }

  _onChangeOnline(
      ChangeOnline event,
      Emitter<HomeState> emit,
      ) async {

    emit(state.copyWith(statusButton: StatusButton.loading));

    try {
      final responseJson= await apiService.put('visitor/status',queryParameters: {
        "status": event.value,
      } );




      await sharedPrefService.setInt(ISONLINE, event.value);






      emit(state.copyWith(statusButton: StatusButton.success,isOnline: event.value));



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
