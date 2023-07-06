import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket/models/list_movie_model.dart';
import 'package:movie_ticket/models/movie_model.dart';
import 'package:movie_ticket/models/repositories/movie_repository.dart';

import '../models/advertisement_model.dart';
import '../models/recommended_model.dart';
import '../models/repositories/recommended_repository.dart';

class MovieService extends ChangeNotifier {
  final MovieRepository movieRepository = MovieRepository();
  MovieModel? selectedMovie;
  String selectedMovieId = "";
  ListMovieModel? specialList;
  ListMovieModel? nowShowingList;
  ListMovieModel? comingSoonList;

  final RecommendedRepository recommendedRepository = RecommendedRepository();
  List<RecommendedModel> listRecommended = [];
  List<AdvertisementModel> listAdvertisement = [];
  AdvertisementModel? selectedAd;
  String? selectedAdId;

  void getSpecialListFromApi() async {
    final list = await movieRepository.getListMovie("special");
    specialList = list;
    notifyListeners();
  }

  void getNowShowingListFromApi() async {
    final list = await movieRepository.getListMovie("nowshowing");
    nowShowingList = list;
    notifyListeners();
  }

  void getComingSoonListFromApi() async {
    final list = await movieRepository.getListMovie("comingsoon");
    comingSoonList = list;
    notifyListeners();
  }

  Future<void> getDetailMovieFromApi(String? movieId) async {
    final movie = await movieRepository.getDetailMovie(movieId);
    selectedMovie = movie;
    notifyListeners();
  }

  void getListRecommendedFromApi() async {
    final list = await recommendedRepository.getListRecommended();

    listRecommended = list;
    notifyListeners();
  }

  void getListAdvertisementFromApi() async {
    ;
    final list = await recommendedRepository.getListAdvertisement();
    listAdvertisement = list;
    notifyListeners();
  }

  void getDetailAdvertisementFromApi(String? advertisementId) async {
    final ad =
        await recommendedRepository.getDetailAdvertisement(advertisementId);
    selectedAd = ad;
    notifyListeners();
  }
}
