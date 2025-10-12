part of 'update_result_bloc.dart';

 class UpdateResultEvent extends Equatable {
  const UpdateResultEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChangeVisitDate extends UpdateResultEvent{
  final String value;

  ChangeVisitDate({required this.value});
}

class ChangeDescription extends UpdateResultEvent{
  final String value;

  ChangeDescription({required this.value});
}

class ChangeResult extends UpdateResultEvent{
  final UserType value;

  ChangeResult({required this.value});
}

class UpdateResult extends UpdateResultEvent{}


