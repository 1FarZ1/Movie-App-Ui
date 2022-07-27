import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math/Screens/detailes.dart';
import 'package:math/const.dart';
import 'package:math/models/movie.dart';

class Home extends StatelessWidget {
  List<String> Categories = [
    "Drama",
    "Action",
    "Comedy",
    "Sport",
    "Family",
    "Kids",
    "Adults",
    "Sc-fi",
    "Comic",
    "Anime",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 30,
          leading: Padding(
            padding: const EdgeInsets.only(left: 13.0),
            child: Icon(
              Icons.density_medium,
              color: Colors.black,
            ),
          ),
          actions: [
            Row(
              children: [
                Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 20,
                )
              ],
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Head(),
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          ...List.generate(Categories.length, (index) {
                            return CategoriesCard(Categories[index]);
                          })
                        ],
                      ))),
              SizedBox(
                height: 10,
              ),
              Movies()
            ],
          ),
        ));
  }
}

class CategoriesCard extends StatelessWidget {
  final String name;
  CategoriesCard(this.name);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 13),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 20),
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

class Head extends StatefulWidget {
  @override
  State<Head> createState() => _HeadState();
}

class _HeadState extends State<Head> {
  int current_section = 0;
  List<String> heads = ["In Theatre","Box office","Coming soon"];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
     
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount:heads.length,
        itemBuilder:(context, index){
         return Padding(
          padding: const EdgeInsets.symmetric(horizontal:10.0),
          child: InkWell(
            onTap: () {
              print(current_section);
              print(index);
              setState(() {
                current_section = index;
              });
            },
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heads[index],
                    style: TextStyle(
                        color: current_section == index
                            ? kTextColor
                            : kTextLightColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                  Visibility(
                    visible: current_section == index,
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      height: 6,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kSecondaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
        }
      ),
    );
  }
}

class Movies extends StatefulWidget {
  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  PageController? _Controller;
  Animation? _AController;
  int initialPagevar = 1;
  @override
  void initState() {
    super.initState();
    _Controller = PageController(
      // so that we can have small portion shown on left and right side
      viewportFraction: 0.8,
      // by default our movie poster
      initialPage: initialPagevar,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _Controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: AspectRatio(
          aspectRatio: 0.9,
          child: PageView.builder(
            onPageChanged: (index) {
              setState(() {
                initialPagevar = index;
              });
            },
            controller: _Controller,
            itemCount: movies.length,
            physics: ClampingScrollPhysics(),
            itemBuilder: (ctx, index) {
              return AnimatedBuilder(
                  animation: _Controller as Listenable,
                  builder: (ctx, child) {
                    double value = 0;

                    if (_Controller!.position.haveDimensions) {
                      value = index - (_Controller?.page as double);

                      // We use 0.038 because 180*0.038 = 7 almost and we need to rotate our poster 7 degree
                      // we use clamp so that our value vary from -1 to 1
                      value = (value * 0.038).clamp(-1, 1);
                    }
                    return AnimatedOpacity(
                        duration: Duration(milliseconds: 350),
                        opacity: initialPagevar == index ? 1 : 0.4,
                        child: Transform.rotate(
                            angle: pi * value,
                            child: MovieCard(movies[index])));
                  });
            },
          ),
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  MovieCard(this.movie);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return Details(movie);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [kDefaultShadow],
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(movie.poster as String)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(movie.title as String,
                  style: TextStyle(
                      wordSpacing: 2,
                      color: kTextColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w600)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 15,
                ),
                SizedBox(
                  width: 3,
                ),
                Text("${movie.rating}",
                    style: TextStyle(
                        color: kTextColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w500)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
