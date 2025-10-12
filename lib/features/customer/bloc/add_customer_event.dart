part of 'add_customer_bloc.dart';

@immutable
sealed class AddCustomerEvent {}

class ChangeTypeBussiness extends AddCustomerEvent{
  final UserType value;

  ChangeTypeBussiness({required this.value});
}
class ChangeKindBussiness extends AddCustomerEvent{
  final UserType value;

  ChangeKindBussiness({required this.value});
}

class ChangeNameSet extends AddCustomerEvent{
  final String value;

  ChangeNameSet({required this.value});
}

class ChangePhoneNumberSet extends AddCustomerEvent{
  final String value;

  ChangePhoneNumberSet({required this.value});
}

class ChangeNameOwnerSet extends AddCustomerEvent{
  final String value;

  ChangeNameOwnerSet({required this.value});
}

class ChangeNameIdentity extends AddCustomerEvent{
  final String value;

  ChangeNameIdentity({required this.value});
}

class ChangeResponsiblePosition extends AddCustomerEvent{
  final UserType value;

  ChangeResponsiblePosition({required this.value});
}

class ChangeResponsibleName extends AddCustomerEvent{
  final String value;

  ChangeResponsibleName({required this.value});
}
class ChangeResponsiblePhoneNumber extends AddCustomerEvent{
  final String value;

  ChangeResponsiblePhoneNumber({required this.value});
}
class ChangeResponsibleCode extends AddCustomerEvent{
  final String value;

  ChangeResponsibleCode({required this.value});
}
class ChangeVisitDate extends AddCustomerEvent{
  final String value;

  ChangeVisitDate({required this.value});
}
class ChangeVisitTime extends AddCustomerEvent{
  final String value;

  ChangeVisitTime({required this.value});
}
class ChangeDescription extends AddCustomerEvent{
  final String value;

  ChangeDescription({required this.value});
}

class ChangeResult extends AddCustomerEvent{
  final UserType value;

  ChangeResult({required this.value});
}

class ChangeFile extends AddCustomerEvent{
  final File? value;

  ChangeFile({required this.value});
}

class ChangeLocation extends AddCustomerEvent{
  final LatLng loc;


  ChangeLocation({required this.loc,});
}

class ChangeTypePage extends AddCustomerEvent{
  final PageAddCustomer value;

  ChangeTypePage({required this.value});
}

class GetOtp extends AddCustomerEvent{

}

class AddCustomer extends AddCustomerEvent{

}

class GetStateEvent extends AddCustomerEvent{

}
class GetCityEvent extends AddCustomerEvent{
    final int id;

  GetCityEvent(this.id);
}

class ChangeSelectedCity extends AddCustomerEvent{
  final City? value;

  ChangeSelectedCity({required this.value});
}


class ChangeSelectedState extends AddCustomerEvent{
  final City? value;

  ChangeSelectedState({required this.value});
}





