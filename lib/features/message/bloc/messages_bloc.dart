import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fare/core/network/api_service.dart';
import 'package:fare/core/utils/enum.dart';
import 'package:flutter/cupertino.dart';

import '../../auth/model/user_model.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final ApiService apiService;
  MessagesBloc(this.apiService) : super(MessagesState(statusButton: StatusButton.none,message: '')) {

    on<GetDataEvent>(_onGetDataEvent);
  }

  _onGetDataEvent(
      GetDataEvent event,
      Emitter<MessagesState> emit,
      ) async {

    emit(state.copyWith(statusButton: StatusButton.loading));

    try {
      final responseJson= await apiService.post('signin',queryParameters:{}  );

      final user =   User.fromJson(responseJson['data']['user']);







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
