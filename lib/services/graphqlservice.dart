import 'package:graphql_flutter/graphql_flutter.dart';

// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjc4NSwiaWF0IjoxNTkwNDk1NDI2LCJleHAiOjE2MjIwMzE0MjZ9.YgRn1CpNaFPmIgHt9GfhSCIS6Cr6FsOp79LHD1JCgxY
class GraphQlService {
  GraphQLClient _mClient;

  GraphQlService(String strLink, {headers}) {
    HttpLink mHttpLink = HttpLink(uri: strLink, headers: headers);

    _mClient = GraphQLClient(link: mHttpLink, cache: InMemoryCache());
  }

  Future<QueryResult> performQuery(query, {variable}) async {
    QueryOptions mQueryOptions =
        QueryOptions(documentNode: gql(query), variables: variable);

    final result = await _mClient.query(mQueryOptions);
    return result;
  }

  Future<QueryResult> performMutation(query, {variable}) async {
    MutationOptions mQueryOptions =
        MutationOptions(documentNode: gql(query), variables: variable);

    final result = await _mClient.mutate(mQueryOptions);
    return result;
  }
}
