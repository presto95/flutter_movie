import 'package:flutter/material.dart';
import 'package:flutter_movie/model/Sorts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_movie/model/remote/Movie.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<Movie> _getMovieList() async {
    http.Response response =
        await http.get('http://connect-boxoffice.run.goorm.io/movies');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Movie.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('예매율순'),
        actions: <Widget>[
          PopupMenuButton<String>(
            icon: Icon(Icons.sort),
            onSelected: clickFilter,
            itemBuilder: (BuildContext context) {
              return Sorts.filters.map((String sort) {
                return PopupMenuItem<String>(
                  value: sort,
                  child: Text(sort),
                );
              }).toList();
            },
          )
        ],
      ),
      body: FutureBuilder<Movie>(
        future: _getMovieList(),
        builder: (BuildContext context, AsyncSnapshot<Movie> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return showLoading();
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return new Text(snapshot.data.movies[0].title);
          }
        },
      ),
    );
  }

  void clickFilter(String sort) {
    print(sort);
  }

  Widget showLoading() {
    return Container(
      alignment: Alignment.center,
      child: new CircularProgressIndicator(),
    );
  }
}
