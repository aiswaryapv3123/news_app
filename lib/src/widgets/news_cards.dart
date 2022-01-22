import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/constants/constants.dart';

class NewsCard extends StatefulWidget {
  const NewsCard({Key key, this.title, this.image,this.description, this.onPressed}) : super(key: key);
  final String title;
  final String image;
  final String description;
  final Function onPressed;

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: AppConstants.colors[2]),
      child:Column(
        children:[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            child: CachedNetworkImage(
              imageUrl: widget.image,
              fit: BoxFit.fill,
              placeholder: (context, img) => Center(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(AppConstants.colors[3])
                    )),
              ),
              errorWidget: (_, s, d) => Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: 20,
                ),
              ),
            ),
          )
        ]
      )
    );
  }
}
