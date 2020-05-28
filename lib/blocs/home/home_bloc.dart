import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter_demo/blocs/home/home_events.dart';
import 'package:graphql_flutter_demo/blocs/home/home_state.dart';
import 'package:graphql_flutter_demo/services/graphqlservice.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {
  GraphQlService _graphQlService;

  HomeBloc() {
    _graphQlService = GraphQlService('https://countries.trevorblades.com/');
  }

  @override
  HomeState get initialState => Loading();

  @override
  Stream<HomeState> mapEventToState(HomeEvents event) async* {
    if (event is FetchHomeData) {
      yield* _mapFetchHomeDataToStates(event);
    }
  }

  Stream<HomeState> _mapFetchHomeDataToStates(FetchHomeData event) async* {
    final query = event.query;
    final variables = event.variable ?? null;
    try {
      final result =
          await _graphQlService.performMutation(query, variable: variables);
      if (result.hasException) {
        yield LoadDataFailed(result.exception.graphqlErrors[0]);
      } else {
        yield LoadDataSuccess(result.data);
      }
    } catch (e) {
      print(e);
      yield LoadDataFailed(e.toString());
    }
  }
}
