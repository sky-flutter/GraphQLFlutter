import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter_demo/blocs/file_upload/file_upload_bloc.dart';
import 'package:graphql_flutter_demo/blocs/home/home_events.dart';
import 'package:graphql_flutter_demo/blocs/simple_bloc_delegate.dart';
import 'package:graphql_flutter_demo/file_upload.dart';
import 'package:graphql_flutter_demo/get_data.dart';
import 'package:graphql_flutter_demo/query_mutation/schema.dart';

import 'blocs/home/home_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
              create: (context) => HomeBloc()
                ..add(
                    FetchHomeData(continentsQuery, variable: {"code": "AS"}))),
          BlocProvider<FileUploadBloc>(
            create: (context) => FileUploadBloc(),
            child: FileUpload(),
          )
        ],
        child: MaterialApp(
          home: MyApp(),
        )),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GraphQL Flutter"),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 16,
              ),
              Container(
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => GetData()));
                  },
                  child: Text("Get Data"),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => FileUpload()));
                },
                child: Text("File Upload"),
              ),
            ],
          ),
        ));
  }
}
