abstract class AppState {}

class AppInitial extends AppState {}

class AppLoading extends AppState{}

class AppFailed extends AppState {
  final String error;

  AppFailed({required this.error});
  @override
  List<Object?> get props => [error];
}

class AppSuccess extends AppState {
  @override
  List data;

  AppSuccess({required this.data});
  @override
  List<Object?> get props => [data];
}
