part of 'list_customer_bloc.dart';

 class ListCustomerState extends Equatable {
  final StatusButton statusButton;
  final String message;
  final List<Customer> listCustomer;
  const ListCustomerState({required this.listCustomer,required this.statusButton,required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [statusButton,message,listCustomer,];

  ListCustomerState copyWith({

   String? message,
   StatusButton? statusButton,
    List<Customer>? listCustomer
  })=> ListCustomerState(

   listCustomer: listCustomer ?? this.listCustomer,
   message: message ?? this.message,
   statusButton: statusButton ?? this.statusButton,


  );
}

