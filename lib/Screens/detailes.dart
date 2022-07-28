import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:math/const.dart';
import 'package:math/models/movie.dart';

class Details extends StatelessWidget {
  final Movie movie;
  Details(this.movie);
  List<String>? genre = [];

  @override
  Widget build(BuildContext context) {
    genre = movie.genra;
    var size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Column(
              children: [
                Header(size: size, movie: movie),
                SizedBox(
                  height: size.height * 0.09,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: "${movie.title}\n\n",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                                text: "${movie.year}     PG-16      2h31min",
                                style: TextStyle(color: kTextLightColor)),
                          ],
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: Color(0xffFF6C90),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.all(18),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 35.0, horizontal: 10),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        height: size.height * 0.05,
                        child: Row(
                          children: [
                            ...List.generate(genre!.length,
                                (index) => CategoriesCard(genre![index]))
                          ],
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Plot Summary\n\n",
                          style: TextStyle(
                              fontSize: 27, fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                            text: movie.plot,
                            style: TextStyle(
                                height: 1.5,
                                color: kTextLightColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Text(
                        "Cast & Crew",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(children: [
                      ...List.generate(movie.cast!.length, (index) {
                        var first_name = movie.cast![index]["original_name"];
                        var Last_name = movie.cast![index]["original_name"];

                        return ActorCard(
                          first_name,
                          movie.cast![index]["movieName"],
                          movie.cast![index]["image"],
                          Last_name,
                        );
                      })
                    ]),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.size,
    required this.movie,
  }) : super(key: key);

  final Size size;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.35,
      child: Stack(
        children: [
          Container(
            child: Container(
              height: size.height * 0.35 - 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(60)),
                  image: DecorationImage(
                      alignment: AlignmentDirectional.topCenter,
                      fit: BoxFit.cover,
                      image: NetworkImage(movie.backdrop as String))),
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 25),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 30,
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                  padding: EdgeInsets.fromLTRB(40, 9, 10, 18),
                  width: size.width * 0.93,
                  height: size.height * 0.128,
                  decoration: BoxDecoration(
                    boxShadow: [kDefaultShadow],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        topLeft: Radius.circular(60)),
                    color: Colors.white,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset("assets/icons/star_fill.svg"),
                            SizedBox(height: kDefaultPadding / 4),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: "${movie.rating}/",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextSpan(text: "10\n"),
                                  TextSpan(
                                    text: '${movie.numOfRatings}' as String,
                                    style: TextStyle(color: kTextLightColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Rate this
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset("assets/icons/star.svg"),
                            SizedBox(height: kDefaultPadding / 2),
                            Text("Rate This",
                                style: Theme.of(context).textTheme.bodyText2),
                          ],
                        ),
                        // Metascore
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Color(0xFF51CF66),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Text(
                                "${movie.metascoreRating}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: kDefaultPadding / 4),
                            Text(
                              "Metascore",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${movie.criticsReview} critic reviews",
                              style: TextStyle(color: kTextLightColor),
                            )
                          ],
                        )
                      ])))
        ],
      ),
    );
  }
}

class ActorCard extends StatelessWidget {
  final String first_name;
  final String last_name;
  final String job;
  final String path;
  ActorCard(this.first_name, this.job, this.path, this.last_name);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.network(
              this.path,
              fit: BoxFit.cover,
              height: 80.0,
              width: 70.0,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(this.first_name,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          Text(this.last_name,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          SizedBox(
            height: 4,
          ),
          Text(this.job,
              style: TextStyle(
                  color: kTextLightColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class CategoriesCard extends StatelessWidget {
  final String name;
  const CategoriesCard(this.name);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [kDefaultShadow],
              color: Colors.white),
          child: Text(
            this.name,
            style: TextStyle(
                color: kTextColor, fontWeight: FontWeight.w500, fontSize: 16),
          )),
    );
  }
}
