import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecases.dart';
import '../../../../core/utils/language_helper.dart';
import '../../data/models/app_language_model.dart';
import '../../domain/entity/app_language.dart';
import '../../domain/use_cases/get_language.dart';
import '../../domain/use_cases/set_language.dart';

part 'app_language_event.dart';
part 'app_language_state.dart';

class AppLanguageBloc extends Bloc<AppLanguageEvent, AppLanguageState> {
  final GetLanguage getLanguage;
  final SetLanguage setLanguage;
  final LanguageHelper helper;


  AppLanguageBloc({
    required this.getLanguage,
    required this.helper,
    required this.setLanguage,


  }) : super(AppLanguageState(language: getLanguage(), )) {
    on<SetAppLanguageEvent>(_onSetAppLanguageEvent);

  }





  Future<void> _onSetAppLanguageEvent(
    SetAppLanguageEvent event,
    Emitter<AppLanguageState> emit,
  ) async {
    final appLanguage = helper.convertToAppLanguage(event.tag);
    setLanguage(Params(language: appLanguage));

    emit(ChangeSuccessState(
        language: appLanguage,
        list: state.listLanguage,
        ));


  }




}


