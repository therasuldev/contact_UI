import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {}

class AppInitial extends AppState {
  @override
  List<Object?> get props => [];
}

class AppLoading extends AppState {
  @override
  List<Object?> get props => [];
}

class AppFailed extends AppState {
  final String error;
  AppFailed({required this.error});
  
  @override
  List<Object?> get props => [error];
}

class AppSuccess extends AppState {
  final List data;
  AppSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}
