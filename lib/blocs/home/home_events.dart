import 'package:equatable/equatable.dart';

abstract class HomeEvents extends Equatable {
  HomeEvents();

  @override
  List<Object> get props => null;
}

class FetchHomeData extends HomeEvents {
  final String query;
  final Map<String, dynamic> variable;

  FetchHomeData(this.query, {this.variable}) : super();

  @override
  List<Object> get props => [query, variable];
}
