part of 'messages_bloc.dart';

 class MessagesState extends Equatable {
  final StatusButton statusButton;
  final String message;
  const MessagesState({required this.statusButton,required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [statusButton,message];

  MessagesState copyWith({

   String? message,
   StatusButton? statusButton,
  })=> MessagesState(

   message: message ?? this.message,
   statusButton: statusButton ?? this.statusButton,


  );
}

