import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  HomeState();

  @override
  List<Object> get props => null;
}

class Loading extends HomeState {
  Loading() : super();
}

class LoadDataSuccess extends HomeState {
  final dynamic data;

  LoadDataSuccess(this.data) : super();

  @override
  List<Object> get props => data;
}

class LoadDataFailed extends HomeState {
  final dynamic error;

  LoadDataFailed(this.error) : super();

  @override
  List<Object> get props => error;
}
