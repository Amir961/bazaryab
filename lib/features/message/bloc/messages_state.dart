part of 'messages_bloc.dart';

 class MessagesState extends Equatable {
  final StatusButton statusButton;
  final String message;
  final List listMessage;
  const MessagesState({required this.listMessage,required this.statusButton,required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [listMessage,statusButton,message];

  MessagesState copyWith({

   String? message,
   List? listMessage,
   StatusButton? statusButton,
  })=> MessagesState(

   message: message ?? this.message,
   statusButton: statusButton ?? this.statusButton,
   listMessage: listMessage ?? this.listMessage,


  );
}

