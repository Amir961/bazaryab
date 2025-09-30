part of 'list_customer_bloc.dart';

 class ListCustomerState extends Equatable {
  final StatusButton statusButton;
  final String message;
  const ListCustomerState({required this.statusButton,required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [statusButton,message];

  ListCustomerState copyWith({

   String? message,
   StatusButton? statusButton,
  })=> ListCustomerState(

   message: message ?? this.message,
   statusButton: statusButton ?? this.statusButton,


  );
}

