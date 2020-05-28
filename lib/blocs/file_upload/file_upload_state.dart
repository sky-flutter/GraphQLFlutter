import 'package:equatable/equatable.dart';

abstract class FileUploadState extends Equatable {
  FileUploadState();

  @override
  List<Object> get props => null;
}

class FileUploadUnIntialized extends FileUploadState {
  FileUploadUnIntialized() : super();
}

class FileUploadLoading extends FileUploadState {
  FileUploadLoading() : super();
}

class FileUploadSuccess extends FileUploadState {
  final dynamic data;

  FileUploadSuccess(this.data) : super();

  @override
  List<Object> get props => data;
}

class FileUploadFailed extends FileUploadState {
  final dynamic error;

  FileUploadFailed(this.error) : super();

  @override
  List<Object> get props => error;
}
