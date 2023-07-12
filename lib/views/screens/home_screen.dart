import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticket/views/widgets/share_widgets/app_bar.dart';
import 'package:movie_ticket/views/widgets/share_widgets/home_movie_list.dart';
import 'package:movie_ticket/views/widgets/share_widgets/drawer.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../model_views/booking_service.dart';
import '../widgets/share_widgets/app_bar_background.dart';
import 'package:provider/provider.dart';
import 'package:movie_ticket/model_views/movie_service.dart';

import '../widgets/share_widgets/home_movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    MovieService movieService =
        Provider.of<MovieService>(context, listen: false);
    movieService.getListRecommendedFromApi();
    movieService.getSpecialListFromApi();
    movieService.getNowShowingListFromApi();
    movieService.getComingSoonListFromApi();
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser!;

  Future navigateToMyTicketScreen() async {
    BookingService bookingService =
        Provider.of<BookingService>(context, listen: false);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 141, 19, 11),
            ),
          );
        });
    await bookingService.getListTicketFromApi(user.uid);
    if (!mounted) return;
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed('/ticket');
  }

  Future navigateToDetailMovieScreen(String movieId) async {
    MovieService movieService =
        Provider.of<MovieService>(context, listen: false);
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 141, 19, 11),
            ),
          );
        });
    await movieService.getDetailMovieFromApi(movieId);
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed("/movie");
  }

  @override
  Widget build(BuildContext context) {
    MovieService movieService = Provider.of<MovieService>(context);
    final specialList = movieService.specialList;
    final nowShowingList = movieService.nowShowingList;
    final comingSoonList = movieService.comingSoonList;
    return specialList != null &&
            nowShowingList != null &&
            comingSoonList != null
        ? Scaffold(
            backgroundColor: Colors.black,
            endDrawer: DrawerWidget(),
            body: CustomScrollView(
              slivers: [
                AppBarWidget(
                  leadingWidget: Icon(
                    CupertinoIcons.tickets_fill,
                    size: 7.w,
                    color: Colors.white,
                  ),
                  leadingOnnClick: () {
                    navigateToMyTicketScreen();
                  },
                  titleWidget: Image.asset('assets/images/netflix.png'),
                  isCenter: true,
                  flexibleSpaceBar: const FlexibleSpaceBar(
                    background: AppBarBackground("assets/images/bat1.jpeg"),
                  ),
                  expandedHeight: 25.h,
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  GestureDetector(
                    onTap: (() {
                      Navigator.of(context).pushNamed("/showtime");
                    }),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.w),
                      child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 150, 3, 3),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          height: 5.h,
                          child: const Center(
                            child: Text(
                              "BOOK NOW",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.w),
                    child: MovieList(
                      listName: specialList.listName,
                      listChild: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: specialList.movies.length,
                          itemBuilder: (context, index) {
                            return MovieCard(
                                title: specialList.movies[index].title,
                                posterPath:
                                    specialList.movies[index].posterPath,
                                ratedSymbol:
                                    specialList.movies[index].rated.symbol,
                                onTap: () {
                                  navigateToDetailMovieScreen(
                                      specialList.movies[index].id);
                                });
                          }),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.w),
                    child: MovieList(
                      listName: nowShowingList.listName,
                      listChild: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: nowShowingList.movies.length,
                          itemBuilder: (context, index) {
                            return MovieCard(
                                title: nowShowingList.movies[index].title,
                                posterPath:
                                    nowShowingList.movies[index].posterPath,
                                ratedSymbol:
                                    nowShowingList.movies[index].rated.symbol,
                                onTap: () {
                                  navigateToDetailMovieScreen(
                                      nowShowingList.movies[index].id);
                                });
                          }),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.w),
                    child: MovieList(
                      listName: comingSoonList.listName,
                      listChild: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: comingSoonList.movies.length,
                          itemBuilder: (context, index) {
                            return MovieCard(
                                title: comingSoonList.movies[index].title,
                                posterPath:
                                    comingSoonList.movies[index].posterPath,
                                ratedSymbol:
                                    comingSoonList.movies[index].rated.symbol,
                                onTap: () {
                                  navigateToDetailMovieScreen(
                                      comingSoonList.movies[index].id);
                                });
                          }),
                    ),
                  ),
                ]))
              ],
            ))
        : Scaffold(
            backgroundColor: Colors.black,
            endDrawer: DrawerWidget(),
            body: CustomScrollView(
              slivers: [
                AppBarWidget(
                  leadingWidget: Icon(
                    CupertinoIcons.tickets_fill,
                    size: 7.w,
                    color: Colors.white,
                  ),
                  leadingOnnClick: () {},
                  titleWidget: Image.asset('assets/images/netflix.png'),
                  isCenter: true,
                  flexibleSpaceBar: const FlexibleSpaceBar(
                    background: AppBarBackground("assets/images/bat1.jpeg"),
                  ),
                  expandedHeight: 25.h,
                ),
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 141, 19, 11),
                    ),
                  ),
                ),
              ],
            ));
  }
}
