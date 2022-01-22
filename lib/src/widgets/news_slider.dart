import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/constants/constants.dart';
import 'package:news_app/src/models/get_news_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsSlider extends StatefulWidget {
  const NewsSlider({Key key, this.news}) : super(key: key);
  final List<Article> news;

  @override
  _NewsSliderState createState() => _NewsSliderState();
}

class _NewsSliderState extends State<NewsSlider> {
  bool select = false;
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SwipeDetector(
      child: Container(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,

        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(15)
        ),
        child: CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
          ),
          items: widget.news
              .map(
                (item) => Container(
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,
                  // margin:EdgeInsets.symmetric(horizontal:5.w),
                  // padding:EdgeInsets.symmetric(horizontal:2.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // image: DecorationImage(
                    //     fit: BoxFit.fill, image: AssetImage(item),),
                  ),
                  child: Column(
                    children: [
                      item.urlToImage == null
                          ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.4,
                              decoration: BoxDecoration(
                                  color: Colors.amber,

                            ),
                    child:Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 20,
                        color: Colors.white,
                      ),
                    ))
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.4,
                              // color: Colors.amber,
                              child: CachedNetworkImage(
                                imageUrl: item.urlToImage,
                                fit: BoxFit.fill,
                                imageBuilder: (context, img) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      // borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: img,
                                      ),
                                    ),
                                  );
                                },
                                placeholder: (context, img) => Center(
                                  child: SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation(
                                              AppConstants.colors[3]))),
                                ),
                                errorWidget: (_, s, d) => Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                      // Container(
                      //         width: MediaQuery.of(context).size.width,
                      //         height: MediaQuery.of(context).size.height * 0.4,
                      //         decoration: BoxDecoration(
                      //           color: Colors.amber,
                      //           image: DecorationImage(
                      //               fit: BoxFit.fill,
                      //               image: NetworkImage(item.url.split('')[0])),
                      //           // child: Image.network(
                      //           //   item.url,
                      //           //   fit: BoxFit.fill,
                      //           //   width: MediaQuery.of(context).size.width,
                      //           //   height:
                      //           //       MediaQuery.of(context).size.height * 0.1,
                      //         ),
                      //       ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.02,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Text(item.title,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: 20,
                                    height: 1.2,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                                item.publishedAt == null
                                    ? 'not available'
                                    : item.publishedAt.toString().split(" ")[0],
                                style: TextStyle(
                                    height: 1.2,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.3))),
                            Divider(color: Colors.grey.shade300),
                            Text(item.author == null ? "Author" : item.author.toString(),
                                style: TextStyle(
                                    height: 1.2,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.3))),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Text(
                                item.description == null
                                    ? 'not available '
                                    : item.description,
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    height: 1.2,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.5))),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            item.urlToImage == null
                                ? Container()
                                : Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap:() async {
                                            final url = item.url;
                                            if (await canLaunch(url)) {
                                              await launch(url);
                                            } else {
                                              throw 'Could not launch $url';
                                            }
                                            },
                                          child: Text("View More",
                                              style: TextStyle(
                                                  height: 1.2,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black
                                                      .withOpacity(0.3))),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                        )
                                      ],
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
