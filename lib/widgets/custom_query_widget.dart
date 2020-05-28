import 'package:graphql_flutter/graphql_flutter.dart';

query(query, {variables, pollInterval, QueryBuilder builder}) {
  return Query(
      options: QueryOptions(
          documentNode: gql(query),
          variables: variables,
          pollInterval: pollInterval),
      builder: builder);
}
