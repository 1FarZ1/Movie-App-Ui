import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math/Network/manager.dart';
import 'package:math/Screens/detailes.dart';
import 'package:math/const.dart';
import 'package:math/models/movie.dart';

var selected_section = 0;
var sections = [
  DataManager.Tmovies_api,
  DataManager.Bmovies_api,
  DataManager.Cmovies_api
];

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List movies = [];
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
  void manage(var a) {
    movies = a;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 30,
          leading: Builder(

            builder:(context)=> Padding(
              padding: const EdgeInsets.only(left: 13.0),
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Icon(
                  Icons.density_medium,
                  color: Colors.black,
                ),
              ),
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
        drawer:   Drawer(
          width: 250,
          elevation: 0,
                  child: ListView(
                    // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: [
                       DrawerHeader(
                        
                        padding: EdgeInsets.all(50),
                        margin: EdgeInsets.zero,
                        curve: Curves.bounceOut,
                        decoration: BoxDecoration(
                          image:DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/backdrop_2.jpg")
                            ),
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        child: Text('',style:TextStyle(
                          color:Colors.white,
                         
                          )),
                      ),
                      ListTile(
                        title: const Text('Movies'),
                        onTap: () {
                          // Update the state of the app.
                          // ...
                        },
                      ),
                      ListTile(
                        title: const Text('about us'),
                        onTap: () {
                          // Update the state of the app.
                          // ...
                        },
                      ),
                    ],
                  ),
                ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Head(() {
                  setState(() {
                    print("me");
                  });
                }),
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
              FutureBuilder(
                future: DataManager.getMovies(sections[selected_section]),
                builder: (BuildContext ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    manage(snapshot.data);
                    return Movies(movies);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )
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
  VoidCallback fun;
  Head(this.fun);
  @override
  State<Head> createState() => _HeadState();
}

class _HeadState extends State<Head> {
  int current_section = 0;
  List<String> heads = ["In Theatre", "Box office", "Coming soon"];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: heads.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  selected_section = index;
                  widget.fun();
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
        },
      ),
    );
  }
}

class Movies extends StatefulWidget {
  List movies;
  Movies(this.movies);
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
            itemCount: widget.movies.length,
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
                            child: MovieCard(widget.movies[index])));
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
                        image: NetworkImage(movie.poster as String)),
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
