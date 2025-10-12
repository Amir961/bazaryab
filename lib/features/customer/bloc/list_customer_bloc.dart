import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fare/core/network/api_service.dart';
import 'package:fare/core/utils/enum.dart';
import 'package:flutter/cupertino.dart';

import '../../auth/model/user_model.dart';

part 'list_customer_event.dart';
part 'list_customer_state.dart';

class ListCustomerBloc extends Bloc<ListCustomerEvent, ListCustomerState> {
  final ApiService apiService;
  ListCustomerBloc(this.apiService) : super(ListCustomerState(statusButton: StatusButton.none,message: '', listCustomer: [])) {

    on<GetDataEvent>(_onGetDataEvent);
  }

  _onGetDataEvent(
      GetDataEvent event,
      Emitter<ListCustomerState> emit,
      ) async {

    emit(state.copyWith(statusButton: StatusButton.loading));

    try {
      final responseJson= await apiService.get('customer',queryParameters:{}  );

    //  final user =   User.fromJson(responseJson['data']['user']);







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
