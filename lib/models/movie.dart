// Our movie model

// The movie class ( movie object that has a several things including him)

// for now we will use our data but later on we will use an api to get Data
import 'package:math/const.dart';

class Movie {
  final int? id, year, numOfRatings, criticsReview, metascoreRating;
  final double? rating;
  final List<String>? genra;
  final String? plot, title, poster, backdrop;
  final List<Map>? cast;

  Movie({
    this.poster, //x
    this.backdrop, //x
    this.title, //x
    this.id, //x
    this.year,  //x
    this.numOfRatings, //x
    this.criticsReview,
    this.metascoreRating,
    this.rating, //x
    this.genra, //x
    this.plot, //x
    this.cast,
  });
}

// our demo data movie data
// List<Movie> movies = [
//   Movie(
//     id: 1,
//     title: "Bloodshot",
//     year: 2020,
//     poster: "assets/images/poster_1.jpg",
//     backdrop: "assets/images/backdrop_1.jpg",
//     numOfRatings: 150212,
//     rating: 7.3,
//     criticsReview: 50,
//     metascoreRating: 76,
//     genra: ["Action", "Drama"],
//     plot: plotText,
//     cast: [
//       {
//         "orginalName": "James Mangold",
//         "movieName": "Director",
//         "image": "assets/images/actor_1.png",
//       },
//       {
//         "orginalName": "Matt Damon",
//         "movieName": "Carroll",
//         "image": "assets/images/actor_2.png",
//       },
//       {
//         "orginalName": "Christian Bale",
//         "movieName": "Ken Miles",
//         "image": "assets/images/actor_3.png",
//       },
//       {
//         "orginalName": "Caitriona Balfe",
//         "movieName": "Mollie",
//         "image": "assets/images/actor_4.png",
//       },
//     ],
//   ),
//   Movie(
//     id: 2,
//     title: "Ford v Ferrari ",
//     year: 2019,
//     poster: "assets/images/poster_2.jpg",
//     backdrop: "${kAPI_ENDPOINT}/hQ4pYsIbP22TMXOUdSfC2mjWrO0.jpg",
//     numOfRatings: 150212,
//     rating: 8.2,
//     criticsReview: 50,
//     metascoreRating: 76,
//     genra: ["Action", "Biography", "Drama"],
//     plot: plotText,
//     cast: [
//       {
//         "orginalName": "James Mangold",
//         "movieName": "Director",
//         "image": "assets/images/actor_1.png",
//       },
//       {
//         "orginalName": "Matt Damon",
//         "movieName": "Carroll",
//         "image": "assets/images/actor_2.png",
//       },
//       {
//         "orginalName": "Christian Bale",
//         "movieName": "Ken Miles",
//         "image": "assets/images/actor_3.png",
//       },
//       {
//         "orginalName": "Caitriona Balfe",
//         "movieName": "Mollie",
//         "image": "assets/images/actor_4.png",
//       },
//     ],
//   ),
//   Movie(
//     id: 1,
//     title: "Onward",
//     year: 2020,
//     poster: "assets/images/poster_3.jpg",
//     backdrop: "assets/images/backdrop_3.jpg",
//     numOfRatings: 150212,
//     rating: 7.6,
//     criticsReview: 50,
//     metascoreRating: 79,
//     genra: ["Action", "Drama"],
//     plot: plotText,
//     cast: [
//       {
//         "orginalName": "James Mangold",
//         "movieName": "Director",
//         "image": "assets/images/actor_1.png",
//       },
//       {
//         "orginalName": "Matt Damon",
//         "movieName": "Carroll",
//         "image": "assets/images/actor_2.png",
//       },
//       {
//         "orginalName": "Christian Bale",
//         "movieName": "Ken Miles",
//         "image": "assets/images/actor_3.png",
//       },
//       {
//         "orginalName": "Caitriona Balfe",
//         "movieName": "Mollie",
//         "image": "assets/images/actor_4.png",
//       },
//     ],
//   ),
// ];

// String plotText =
//     "American car designer Carroll Shelby and driver Kn Miles battle corporate interference and the laws of physics to build a revolutionary race car for Ford in order.";
