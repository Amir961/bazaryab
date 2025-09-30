part of 'home_bloc.dart';

 class HomeState extends Equatable {
  final StatusButton statusButton;
  final int isOnline;
  final String message;
  final User? user;
  const HomeState({required this.user,required this.message,required this.statusButton,required this.isOnline});

  @override
  // TODO: implement props
  List<Object?> get props => [user,statusButton,isOnline,message];

  HomeState copyWith({
  int? isOnline,
   String? message,
   User? user,
   StatusButton? statusButton,
  })=> HomeState(

   user: user ?? this.user,
   isOnline: isOnline ?? this.isOnline,
   message: message ?? this.message,
   statusButton: statusButton ?? this.statusButton,


  );
}


