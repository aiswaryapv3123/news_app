import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/api/services.dart';
import 'package:news_app/src/bloc/news_bloc.dart';
import 'package:news_app/src/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home:HomePage(),
      // BlocProvider(
      //   create: (context) => NewsDataBloc(newsDataRepo: NewsDataServices()),
      //   child: HomePage(),
      // ),
    );
  }
}

