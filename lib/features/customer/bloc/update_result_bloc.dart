import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fare/core/network/api_service.dart';
import 'package:fare/core/utils/enum.dart';
import 'package:fare/features/splash/presentation/models/common_setting.dart';
import 'package:flutter/cupertino.dart';

part 'update_result_event.dart';
part 'update_result_state.dart';

class UpdateResultBloc extends Bloc<UpdateResultEvent, UpdateResultState> {
  final ApiService apiService;
  UpdateResultBloc(this.apiService) : super(UpdateResultState(description: '',
      message: '',
      visitDate: '',
      statusButton: StatusButton.none,
      result: null)) {

    on<ChangeVisitDate>(_onChangeVisitDate);

    on<ChangeDescription>(_onChangeDescription);
    on<ChangeResult>(_onChangeResult);
    on<UpdateResult>(_onUpdateResult);

  }

  _onUpdateResult(
      UpdateResult event,
      Emitter<UpdateResultState> emit,
      ) async {

    emit(state.copyWith(statusButton: StatusButton.loading));
    Map<String, dynamic> variables = {
    };



    variables.addAll({"description": state.description});

    variables.addAll({"visit_date": state.visitDate?.split(' ')[1]});
    variables.addAll({"visit_time": state.visitDate?.split(' ')[0]});
    variables.addAll({"result": state.result?.key});


    debugPrint('variables_is: ${variables.toString()}');

    try {
      final responseJson= await apiService.put('customer/${event.id}',queryParameters: variables);

      debugPrint('data_is: ${responseJson.toString()}');
      final key= responseJson['data'];







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
    emit(state.copyWith(statusButton: StatusButton.success));
  }

  _onChangeResult(
      ChangeResult event,
      Emitter<UpdateResultState> emit,
      ) async {

    emit(state.copyWith(result: event.value));
  }

  _onChangeDescription(
      ChangeDescription event,
      Emitter<UpdateResultState> emit,
      ) async {

    emit(state.copyWith(description: event.value));
  }



  _onChangeVisitDate(
      ChangeVisitDate event,
      Emitter<UpdateResultState> emit,
      ) async {

    emit(state.copyWith(visitDate: event.value));
  }
}