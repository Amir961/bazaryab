part of 'update_customer_bloc.dart';


@immutable
sealed class UpdateCustomerEvent {}

class ChangeTypeBussiness extends UpdateCustomerEvent{
  final UserType? value;

  ChangeTypeBussiness({required this.value});
}
class ChangeKindBussiness extends UpdateCustomerEvent{
  final UserType? value;

  ChangeKindBussiness({required this.value});
}

class ChangeNameSet extends UpdateCustomerEvent{
  final String value;

  ChangeNameSet({required this.value});
}

class ChangePhoneNumberSet extends UpdateCustomerEvent{
  final String value;

  ChangePhoneNumberSet({required this.value});
}

class ChangeNameOwnerSet extends UpdateCustomerEvent{
  final String value;

  ChangeNameOwnerSet({required this.value});
}

class ChangeNameIdentity extends UpdateCustomerEvent{
  final String value;

  ChangeNameIdentity({required this.value});
}

class ChangeResponsiblePosition extends UpdateCustomerEvent{
  final UserType? value;

  ChangeResponsiblePosition({required this.value});
}

class ChangeResponsibleName extends UpdateCustomerEvent{
  final String value;

  ChangeResponsibleName({required this.value});
}
class ChangeResponsiblePhoneNumber extends UpdateCustomerEvent{
  final String value;

  ChangeResponsiblePhoneNumber({required this.value});
}
class ChangeResponsibleCode extends UpdateCustomerEvent{
  final String value;

  ChangeResponsibleCode({required this.value});
}
class ChangeVisitDate extends UpdateCustomerEvent{
  final String value;

  ChangeVisitDate({required this.value});
}
class ChangeVisitTime extends UpdateCustomerEvent{
  final String value;

  ChangeVisitTime({required this.value});
}
class ChangeDescription extends UpdateCustomerEvent{
  final String value;

  ChangeDescription({required this.value});
}

class ChangeResult extends UpdateCustomerEvent{
  final UserType? value;

  ChangeResult({required this.value});
}

class ChangeFile extends UpdateCustomerEvent{
  final File? value;

  ChangeFile({required this.value});
}

class ChangeLocation extends UpdateCustomerEvent{
  final LatLng loc;


  ChangeLocation({required this.loc,});
}

class ChangeTypePage extends UpdateCustomerEvent{
  final PageAddCustomer value;

  ChangeTypePage({required this.value});
}

class GetOtp extends UpdateCustomerEvent{

}

class AddCustomerOtp extends UpdateCustomerEvent{

}

class GetStateEvent extends UpdateCustomerEvent{

}
class GetCityEvent extends UpdateCustomerEvent{
  final int id;

  GetCityEvent(this.id);
}

class ChangeSelectedCity extends UpdateCustomerEvent{
  final City? value;

  ChangeSelectedCity({required this.value});
}


class ChangeSelectedState extends UpdateCustomerEvent{
  final City? value;

  ChangeSelectedState({required this.value});
}
class UpdateCustomer extends UpdateCustomerEvent{
  final String id;

  UpdateCustomer({required this.id});
}


