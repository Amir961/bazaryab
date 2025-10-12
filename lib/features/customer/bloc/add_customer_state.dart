part of 'add_customer_bloc.dart';


 class AddCustomerState extends Equatable {
   final StatusButton statusButtonOtp;
   final StatusButton statusButtonAdd;

   final StatusButton statusButtonGetState;
   final StatusButton statusButtonGetCity;
   final City? selectedState;
   final City? selectedCity;

   final List<City> listState;
   final List<City> listCity;

   final UserType? typeBussiness;
   final UserType? kindBussiness;
   final String nameSet;
   final String nameOwnerSet;
   final String phoneNumberSet;
   final String identity;
   final UserType? responsiblePosition;
   final String responsibleName;
   final String responsiblePhoneNumber;
   final String responsibleCode;
   final String? visitDate;
   final String? visitTime;
   final String message;
   final UserType? result;
   final String description;
   final String key;
   final File? file;
   final LatLng? loc;
   final PageAddCustomer pageAddCustomer;

  AddCustomerState({required this.listCity,required this.listState,required this.selectedCity,required this.selectedState,required this.statusButtonGetCity,required this.statusButtonGetState,required this.key,required this.phoneNumberSet,required this.pageAddCustomer,required this.loc,required this.message,required this.statusButtonOtp, required this.statusButtonAdd, required this.typeBussiness, required this.kindBussiness, required this.nameSet, required this.nameOwnerSet, required this.identity, required this.responsiblePosition, required this.responsibleName, required this.responsiblePhoneNumber, required this.responsibleCode, required this.visitDate, required this.visitTime, required this.result, required this.description, required this.file});
  @override
  // TODO: implement props
  List<Object?> get props => [loc,selectedState,selectedCity,listCity,listState,statusButtonGetState,statusButtonGetCity,key,phoneNumberSet,pageAddCustomer,message,file,description,result,visitTime,visitDate,responsibleCode,responsiblePhoneNumber,responsibleName,responsiblePosition,identity,identity,nameOwnerSet,nameSet,statusButtonOtp,statusButtonAdd,typeBussiness,kindBussiness];

   AddCustomerState copyWith({
      List<City>? listState,
      List<City>? listCity,
     City? selectedCity,
     City? selectedState,
     PageAddCustomer? pageAddCustomer,
      StatusButton? statusButtonGetCity,
      StatusButton? statusButtonGetState,
      StatusButton? statusButtonOtp,
      StatusButton? statusButtonAdd,
      UserType? typeBussiness,
      UserType? kindBussiness,
      String? nameSet,
      String? phoneNumberSet,
      String? nameOwnerSet,
      String? identity,
      UserType? responsiblePosition,
      String? responsibleName,
      String? responsiblePhoneNumber,
      String? responsibleCode,
      String? visitDate,
      String? visitTime,
      String? message,
      UserType? result,
      String? description,
      String? key,
      File? file,
     LatLng? loc

 })=> AddCustomerState(
     loc: loc?? this.loc,
     listCity: listCity?? this.listCity,
     listState: listState?? this.listState,
     selectedCity: selectedCity?? this.selectedCity,
     selectedState: selectedState?? this.selectedState,
     statusButtonGetCity: statusButtonGetCity?? this.statusButtonGetCity,
     statusButtonGetState: statusButtonGetState?? this.statusButtonGetState,
     phoneNumberSet: phoneNumberSet?? this.phoneNumberSet,
     pageAddCustomer: pageAddCustomer?? this.pageAddCustomer,

     message: message?? this.message,
     statusButtonOtp: statusButtonOtp?? this.statusButtonOtp,
     statusButtonAdd: statusButtonAdd?? this.statusButtonAdd,
     typeBussiness: typeBussiness?? this.typeBussiness,
     kindBussiness: kindBussiness?? this.kindBussiness,
     nameSet: nameSet?? this.nameSet,
     nameOwnerSet: nameOwnerSet?? this.nameOwnerSet,
     identity: identity?? this.identity,
     responsiblePosition: responsiblePosition?? this.responsiblePosition,
     responsibleName: responsibleName?? this.responsibleName,
     responsiblePhoneNumber: responsiblePhoneNumber?? this.responsiblePhoneNumber,
     responsibleCode: responsibleCode?? this.responsibleCode,
     visitDate: visitDate?? this.visitDate,
     visitTime: visitTime?? this.visitTime,
     result: result?? this.result,
     description: description?? this.description,
     file: file?? this.file,
     key: key?? this.key,

   );


   AddCustomerState resetFile()=> AddCustomerState(
     loc: loc,
     listCity: listCity,
     listState: listState,
     selectedCity: selectedCity,
     selectedState: selectedState,
     statusButtonGetCity: statusButtonGetCity,
     statusButtonGetState: statusButtonGetState,
     phoneNumberSet: phoneNumberSet,
     pageAddCustomer: pageAddCustomer,

     message: message,
     statusButtonOtp: statusButtonOtp,
     statusButtonAdd: statusButtonAdd,
     typeBussiness: typeBussiness,
     kindBussiness: kindBussiness,
     nameSet: nameSet,
     nameOwnerSet: nameOwnerSet,
     identity: identity,
     responsiblePosition: responsiblePosition,
     responsibleName: responsibleName,
     responsiblePhoneNumber: responsiblePhoneNumber,
     responsibleCode: responsibleCode,
     visitDate: visitDate,
     visitTime: visitTime,
     result: result,
     description: description,
     file: null,
     key: key,

   );


 }

