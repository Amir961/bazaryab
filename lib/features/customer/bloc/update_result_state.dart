part of 'update_result_bloc.dart';

 class UpdateResultState extends Equatable {
   final String description;
   final String message;
   final String visitDate;
   final StatusButton statusButton;
   final UserType? result;
  const UpdateResultState(
      {required this.description,
        required this.message,
        required this.visitDate,
        required this.statusButton,
        required this.result});

  @override
  List<Object?> get props => [result,description,message,visitDate,statusButton,];

   UpdateResultState copyWith({
    String? description,
    String? message,
    String? visitDate,
    StatusButton? statusButton,
    UserType? result,
  })=> UpdateResultState(
       description: description ?? this.description,
     message: message ?? this.message,
     visitDate: visitDate ?? this.visitDate,
     statusButton: statusButton ?? this.statusButton,
     result: result ?? this.result,
   );

}
