part of 'auth_bloc.dart';


 class AuthState  extends Equatable{
   final String userName;
   final String password;

   final String message;
   final StatusButton statusButton;
   final StatusButton statusLogOut;


  AuthState({required this.statusLogOut,required this.userName,required this.password,required this.statusButton,required this.message,});

   AuthState copyWith({
      String? userName,
      String? password,
      String? message,
      StatusButton? statusButton,
      StatusButton? statusLogOut,
 })=> AuthState(
     userName: userName ?? this.userName,
     password: password ?? this.password,
     message: message ?? this.message,
     statusButton: statusButton ?? this.statusButton,
     statusLogOut: statusLogOut ?? this.statusLogOut,


   );

  @override
  // TODO: implement props
  List<Object?> get props => [  statusLogOut,userName,password,message,statusButton];
}


