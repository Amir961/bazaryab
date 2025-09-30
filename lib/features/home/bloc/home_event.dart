part of 'home_bloc.dart';

 class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChangeOnline extends HomeEvent{
  final int value;

  ChangeOnline({required this.value});
}
