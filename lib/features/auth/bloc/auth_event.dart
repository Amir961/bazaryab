part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChangeUserNameEvent extends AuthEvent{
  final String userName;
  const ChangeUserNameEvent(this.userName);
}

class ChangePasswordEvent extends AuthEvent{
  final String password;
  const ChangePasswordEvent(this.password);
}




class LoginEvent extends AuthEvent{

}





