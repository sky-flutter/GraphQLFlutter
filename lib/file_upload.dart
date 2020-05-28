import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter_demo/blocs/file_upload/file_upload_bloc.dart';
import 'package:graphql_flutter_demo/blocs/file_upload/file_upload_events.dart';
import 'package:graphql_flutter_demo/query_mutation/schema.dart';

import 'blocs/file_upload/file_upload_state.dart';

class FileUpload extends StatefulWidget {
  @override
  _FileUploadState createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  String strImagePath = "";
  FileUploadBloc _fileUploadBloc;
  final scKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _fileUploadBloc = BlocProvider.of<FileUploadBloc>(context);

    return BlocBuilder<FileUploadBloc, FileUploadState>(
        bloc: _fileUploadBloc,
        builder: (BuildContext context, FileUploadState state) {
          return Scaffold(
              key: scKey,
              appBar: AppBar(title: Text("File Upload")),
              body: createScaffold(state));
        });
    // return createScaffold();
  }

  createScaffold(FileUploadState state) {
    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 16,
        ),
        strImagePath != null && strImagePath != ""
            ? Expanded(
                child: Image.file(
                  File(strImagePath),
                ),
              )
            : Container(),
        SizedBox(
          height: 16,
        ),
        checkResult(state),
        SizedBox(
          height: 24,
        ),
      ],
    ));
  }

  pickFile() async {
    File file = await FilePicker.getFile();
    strImagePath = file.path;

    setState(() {});
  }

  checkResult(FileUploadState state) {
    if (state is FileUploadLoading) {
      return showProgress();
    } else if (state is FileUploadSuccess) {
      scKey.currentState.showSnackBar(
          SnackBar(content: Text(state.data['uploadImg']['message'])));
      return button();
    } else if (state is FileUploadFailed) {
      return showError(state);
    } else {
      return button();
    }
  }

  showError(state) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(24),
        child: Text("Error : ${state.error}"),
      ),
    );
  }

  showProgress() {
    return Expanded(
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              width: 16,
            ),
            Text("Uploading file")
          ],
        ),
      ),
    );
  }

  button() {
    return Expanded(
        child: Row(
      children: [
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: RaisedButton(
            onPressed: () {
              pickFile();
            },
            child: Text("Pick Image"),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: RaisedButton(
            onPressed: () {
              if (strImagePath != null && strImagePath != "") {
                Map<String, dynamic> variables = Map<String, dynamic>();
                variables['referenceId'] = 0;
                variables['reference'] = 'demo';
                variables['file'] = File(strImagePath);
                _fileUploadBloc.add(UploadFileDocument(uploadFile, variables));
              }
            },
            child: Text("Upload Image"),
          ),
        ),
        SizedBox(
          width: 16,
        ),
      ],
    ));
  }
}
