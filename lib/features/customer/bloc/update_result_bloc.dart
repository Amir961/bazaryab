import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fare/core/network/api_service.dart';
import 'package:fare/core/utils/enum.dart';
import 'package:fare/features/splash/presentation/models/common_setting.dart';

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
    await Future.delayed(Duration(seconds: 2));
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