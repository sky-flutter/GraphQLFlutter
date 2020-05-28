import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_flutter_demo/blocs/home/home_bloc.dart';
import 'package:graphql_flutter_demo/query_mutation/schema.dart';
import 'package:graphql_flutter_demo/utils/utils.dart';
import 'package:graphql_flutter_demo/widgets/custom_query_widget.dart';

import 'blocs/home/home_state.dart';

class GetData extends StatefulWidget {
  @override
  _GetDataState createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  List data = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
      return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Countries",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.normal),
          ),
        ),
        body: Container(
          child: checkResult(state),
        ),
      );
    });
  }

  checkResult(HomeState state) {
    if (state is Loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is LoadDataFailed) {
      return Center(
        child: Text(state.error.toString()),
      );
    } else {
      data = (state as LoadDataSuccess).data['continent']['countries'];
      return Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return listItem(data[index]);
          },
          itemCount: data.length,
        ),
      );
    }
  }

  listItem(Map<String, dynamic> mapData) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Text(
                localToEmoji(mapData['code']),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                mapData['name'],
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            color: Colors.grey,
            height: 5,
          )
        ],
      ),
    );
  }

  getdata() {
    return query(continentsQuery, builder: (
      QueryResult result, {
      Refetch refetch,
      FetchMore fetchMore,
    }) {
      if (result.loading) {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (result.data != null) {
        print(result.data);
        return Text("Data fetching");
      }

      if (result.hasException) {
        return Text(result.exception.clientException.message);
      }
      return Container();
    });
  }
}
