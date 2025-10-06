import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fare/core/network/api_service.dart';
import 'package:fare/core/utils/enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

import '../../splash/presentation/models/common_setting.dart';
import '../models/city_model.dart';

part 'add_customer_event.dart';
part 'add_customer_state.dart';

class AddCustomerBloc extends Bloc<AddCustomerEvent, AddCustomerState> {
  ApiService apiService;
      AddCustomerBloc(this.apiService) : super(AddCustomerState(loc: null,  message: '', statusButtonOtp: StatusButton.none, statusButtonAdd:  StatusButton.none, typeBussiness: null, kindBussiness: null, nameSet: '', nameOwnerSet: '', identity: '', responsiblePosition: null, responsibleName: '', responsiblePhoneNumber: '', responsibleCode: '', visitDate: null, visitTime: null, result: null, description: '', file: null, pageAddCustomer: PageAddCustomer.completeInfo, phoneNumberSet: '', key: '', statusButtonGetCity: StatusButton.none,statusButtonGetState: StatusButton.none,selectedCity: null,selectedState: null, listCity: [],listState: [])) {

        on<ChangeTypeBussiness>(_onChangeTypeBussiness);
        on<ChangeKindBussiness>(_onChangeKindBussiness);
        on<ChangeNameSet>(_onChangeNameSet);
        on<ChangeNameOwnerSet>(_onChangeNameOwnerSet);
        on<ChangeNameIdentity>(_onChangeNameIdentity);
        on<ChangeResponsiblePosition>(_onChangeResponsiblePosition);
        on<ChangeResponsibleName>(_onChangeResponsibleName);
        on<ChangeResponsiblePhoneNumber>(_onChangeResponsiblePhoneNumber);
        on<ChangeResponsibleCode>(_onChangeResponsibleCode);
        on<ChangeVisitDate>(_onChangeVisitDate);
        on<ChangeVisitTime>(_onChangeVisitTime);
        on<ChangeDescription>(_onChangeDescription);
        on<ChangeResult>(_onChangeResult);
        on<ChangeFile>(_onChangeFile);
        on<ChangeLocation>(_onChangeLocation);
        on<ChangeTypePage>(_onChangeTypePage);
        on<ChangePhoneNumberSet>(_onChangePhoneNumberSet);
        on<GetOtp>(_onGetOtp);
       // on<GetOtp>(_onGetOtp);
        on<GetStateEvent>(_onGetStateEvent);
        on<GetCityEvent>(_onGetCityEvent);
        on<ChangeSelectedState>(_onChangeSelectedState);
        on<ChangeSelectedCity>(_onChangeSelectedCity);
  }

  _onChangeSelectedCity(
      ChangeSelectedCity event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(selectedCity: event.value));
  }


  _onChangeSelectedState(
      ChangeSelectedState event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(selectedState: event.value));
  }


  _onGetCityEvent(
      GetCityEvent event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(statusButtonGetCity: StatusButton.loading));

    try {
      final responseJson= await apiService.get('state/${event.id}' );

      CityModel  listState = CityModel.fromJson( responseJson);







      emit(state.copyWith(statusButtonGetCity: StatusButton.success,listCity: listState.data??[]));



    } on ConnectionException catch (e) {
      debugPrint('error_is: ${e.toString()}');
      emit(state.copyWith(statusButtonGetCity: StatusButton.noInternet));

    } on ApiException catch (e) {
      debugPrint('error_is: ${e.toString()}');
      emit(state.copyWith(statusButtonGetCity: StatusButton.failed,message: e.message));

    } catch (e) {
      emit(state.copyWith(statusButtonGetCity: StatusButton.failed,message: e.toString()));

    }


  }


  _onGetStateEvent(
      GetStateEvent event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(statusButtonGetState: StatusButton.loading));

    try {
      final responseJson= await apiService.get('state' );

      CityModel  listState = CityModel.fromJson( responseJson);







      emit(state.copyWith(statusButtonGetState: StatusButton.success,listState: listState.data??[]));



    } on ConnectionException catch (e) {
      debugPrint('error_is: ${e.toString()}');
      emit(state.copyWith(statusButtonGetState: StatusButton.noInternet));

    } on ApiException catch (e) {
      debugPrint('error_is: ${e.toString()}');
      emit(state.copyWith(statusButtonGetState: StatusButton.failed,message: e.message));

    } catch (e) {
      emit(state.copyWith(statusButtonGetState: StatusButton.failed,message: e.toString()));

    }


  }


  _onGetOtp(
      GetOtp event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(statusButtonOtp: StatusButton.loading));

    try {
      final responseJson= await apiService.post('customer/otp',queryParameters: {
        "in_charge_mobile": state.responsiblePhoneNumber,
      } );

      final key= responseJson['data']['key'];





      emit(state.copyWith(statusButtonOtp: StatusButton.success,key: key));



    } on ConnectionException catch (e) {
      debugPrint('error_is: ${e.toString()}');
      emit(state.copyWith(statusButtonOtp: StatusButton.noInternet));

    } on ApiException catch (e) {
      debugPrint('error_is: ${e.toString()}');
      emit(state.copyWith(statusButtonOtp: StatusButton.failed,message: e.message));

    } catch (e) {
      emit(state.copyWith(statusButtonOtp: StatusButton.failed,message: e.toString()));

    }


  }

  _onChangePhoneNumberSet(
      ChangePhoneNumberSet event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(phoneNumberSet: event.value));
  }

  _onChangeTypePage(
      ChangeTypePage event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(pageAddCustomer: event.value));
  }

  _onChangeLocation(
      ChangeLocation event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(loc: event.loc));
  }

  _onChangeFile(
      ChangeFile event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(file: event.value));
  }

  _onChangeResult(
      ChangeResult event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(result: event.value));
  }

  _onChangeDescription(
      ChangeDescription event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(description: event.value));
  }

  _onChangeVisitTime(
      ChangeVisitTime event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(visitTime: event.value));
  }

  _onChangeVisitDate(
      ChangeVisitDate event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(visitDate: event.value));
  }

  _onChangeResponsibleCode(
      ChangeResponsibleCode event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(responsibleCode: event.value));
  }

  _onChangeResponsiblePhoneNumber(
      ChangeResponsiblePhoneNumber event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(responsiblePhoneNumber: event.value));
  }

  _onChangeResponsibleName(
      ChangeResponsibleName event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(responsibleName: event.value));
  }

  _onChangeResponsiblePosition(
      ChangeResponsiblePosition event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(responsiblePosition: event.value));
  }
  _onChangeNameIdentity(
      ChangeNameIdentity event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(identity: event.value));
  }

  _onChangeNameOwnerSet(
      ChangeNameOwnerSet event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(nameOwnerSet: event.value));
  }

  _onChangeNameSet(
      ChangeNameSet event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(nameSet: event.value));
  }

  _onChangeKindBussiness(
      ChangeKindBussiness event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(kindBussiness: event.value));
  }

  _onChangeTypeBussiness(
      ChangeTypeBussiness event,
      Emitter<AddCustomerState> emit,
      ) async {

    emit(state.copyWith(typeBussiness: event.value));
  }
}
