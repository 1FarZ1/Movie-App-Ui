import 'dart:convert';

import 'package:http/http.dart';
import 'package:math/const.dart';
import 'package:math/models/movie.dart';
import 'package:collection/collection.dart';

const AUTH_KEY = '5587864edf6014223e0aa550dbd614ff';

class DataManager {
  static List<Movie> Movies = [];
  static List<String> Tmovies_api = [
    "Batman",
    "Avengers",
    "the irishman",
  ];
  static List<String> Bmovies_api = [
    "Fight club",
    "The godfather",
    "rush hour",
    "2012"
  ];
  static List<String> Cmovies_api = ["Ted", "spiderman", "Interstellar"];
  static Future<List<Movie>> getMovies(selcted_movies) async {
    Movies.clear();
    for (int x = 0; x < selcted_movies.length; x++) {
      Response data = await get(Uri.parse(
          "https://api.themoviedb.org/3/search/movie?api_key=${AUTH_KEY}&query=${selcted_movies[x]}"));
      var incoming = jsonDecode(data.body)["results"][0];

      var backdrop_image = '$kAPI_ENDPOINT${incoming["backdrop_path"]}';
      var poster_image = '$kAPI_ENDPOINT${incoming["poster_path"]}';
      var name = incoming["original_title"];
      var summary = incoming["overview"];
      var vote_average = incoming["vote_average"];
      var vote_count = incoming["vote_count"];
      var year = incoming["release_date"].split("-")[0];
      var movie_id = incoming["id"];
      List<Map> cast = [];
      List<String> genra = [];
      var genra_ids = incoming["genre_ids"];
      // get the  genra
      Response temp = await get(Uri.parse(
          "https://api.themoviedb.org/3/genre/movie/list?api_key=$AUTH_KEY&language=en-US"));
      var genre_list = jsonDecode(temp.body)["genres"];
      for (int i in genra_ids) {
        for (Map j in genre_list) {
          if (j["id"] == i) {
            genra.add(j["name"]);
          }
        }
      }
      Response temp2 = await get(Uri.parse(
          "https://api.themoviedb.org/3/movie/$movie_id/credits?api_key=$AUTH_KEY"));

      for (int i = 0; i < 4; i++) {
        Map j = jsonDecode(temp2.body)["cast"][i];
        Map actor = {};
        actor["original_name"] = j["name"];
        actor["movieName"] = j["character"];
        actor["image"] = '$kAPI_ENDPOINT${j["profile_path"]}';
        cast.add(actor);
      }

      // print("$name : $vote_average");

      Movies.add(Movie(
        id: x + 1,
        title: name,
        year: int.parse(year),
        poster: poster_image,
        backdrop: backdrop_image,
        numOfRatings: vote_count,
        rating: vote_average.toDouble(),
        criticsReview: 50,
        metascoreRating: 76,
        genra: genra,
        plot: summary,
        cast: cast,
      ));
    }

    return Movies;
  }
}
