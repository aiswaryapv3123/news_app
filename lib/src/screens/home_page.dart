import 'package:flutter/material.dart';
import 'package:news_app/src/api/api_service.dart';
import 'package:news_app/src/bloc/news_bloc.dart';
import 'package:news_app/src/bloc/events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/bloc/states.dart';
import 'package:news_app/src/constants/constants.dart';
import 'package:news_app/src/models/get_news_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news_app/src/widgets/news_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  dynamic data;
  final pageController = PageController();
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * .05,
              ),
              FutureBuilder(
                future: client.getArticle(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Article>> snapshot) {
                  if (snapshot.hasData) {
                    print('Data');
                    List<Article> news = snapshot.data;
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height,
                      child: NewsSlider(
                        news: news,
                      ),
                      // PageView.builder(
                      //   onPageChanged: (i) {
                      //     i == news.length
                      //         ? setState(() {
                      //             i = 0;
                      //           })
                      //         : print("Index " + i.toString());
                      //   },
                      //   // scrollDirection: Axis.vertical,
                      //   itemCount: news.length,
                      //   controller: pageController,
                      //   itemBuilder: (context, index) {
                      //     return Container(
                      //         // width: double.infinity,
                      //         // height: double.infinity,
                      //         child: Text(news[index].title));
                      //   },
                      // ),
                      // ListView.builder(
                      //   itemCount: news.length,
                      //   shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return Container(
                      //         margin: EdgeInsets.symmetric(
                      //             vertical: 4, horizontal: 2),
                      //         child: Text(news[index].title));
                      //   },
                      // ),
                    );
                  }
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Center(
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppConstants.colors[3],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * .10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
