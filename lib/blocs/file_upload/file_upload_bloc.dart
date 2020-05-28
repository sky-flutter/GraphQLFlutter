import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:graphql_flutter_demo/blocs/file_upload/file_upload_events.dart';
import 'package:graphql_flutter_demo/blocs/file_upload/file_upload_state.dart';
import 'package:graphql_flutter_demo/services/graphqlservice.dart';

class FileUploadBloc extends Bloc<FileUploadEvents, FileUploadState> {
  GraphQlService graphQlService;

  FileUploadBloc() {
    Map<String, String> header = HashMap();
    header['access_token'] = "<AUTH_TOKEN>";
    graphQlService =
        GraphQlService('<GRAPHQL_PLAYGROUND_URL>', headers: header);
  }

  @override
  FileUploadState get initialState => FileUploadUnIntialized();

  @override
  Stream<FileUploadState> mapEventToState(FileUploadEvents event) async* {
    if (event is UploadFileDocument) {
      yield* _mapUploadFileDocument(event);
    }
  }

  Stream<FileUploadState> _mapUploadFileDocument(
      UploadFileDocument event) async* {
    final mutation = event.mutation;
    final variables = event.variables;
    yield FileUploadLoading();
    try {
      final result =
          await graphQlService.performMutation(mutation, variable: variables);
      if (result.hasException) {
        yield FileUploadFailed(result.exception.graphqlErrors[0].message);
      } else {
        yield FileUploadSuccess(result.data);
      }
    } catch (e) {
      print("Error : ${e.toString()}");
      yield FileUploadFailed(e.toString());
    }
  }
}
