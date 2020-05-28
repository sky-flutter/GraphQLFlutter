import 'package:equatable/equatable.dart';

abstract class FileUploadEvents extends Equatable {
  FileUploadEvents();

  @override
  List<Object> get props => null;
}

class UploadFileDocument extends FileUploadEvents {
  final String mutation;
  final Map<String, dynamic> variables;

  UploadFileDocument(this.mutation, this.variables) : super();

  @override
  List<Object> get props => [mutation, variables];
}
