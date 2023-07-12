import 'package:flutter/material.dart';
import 'package:movie_ticket/views/widgets/share_widgets/drawer.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

import '../../model_views/movie_service.dart';
import '../widgets/share_widgets/app_bar.dart';

class DetailAdvertisementScreen extends StatefulWidget {
  const DetailAdvertisementScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailAdvertisementScreen> createState() =>
      _DetailAdvertisementScreenState();
}

class _DetailAdvertisementScreenState extends State<DetailAdvertisementScreen> {
  @override
  void initState() {
    MovieService movieService =
        Provider.of<MovieService>(context, listen: false);
    movieService.getDetailAdvertisementFromApi(movieService.selectedAdId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MovieService movieService = Provider.of<MovieService>(context);
    final currentAd = movieService.selectedAd;
    return currentAd != null
        ? Scaffold(
            backgroundColor: Colors.black,
            endDrawer: DrawerWidget(),
            body: Stack(children: [
              CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
                AppBarWidget(
                  leadingWidget: Icon(
                    Icons.adaptive.arrow_back,
                    size: 8.w,
                    color: Colors.white,
                  ),
                  leadingOnnClick: () {
                    Navigator.of(context).pop();
                  },
                  titleWidget: Text(
                    'Advertisement',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                  isCenter: false,
                  expandedHeight: 0,
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  Container(
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(currentAd.posterPath),
                            fit: BoxFit.fill)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Text(
                      currentAd.title,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ]))
              ])
            ]))
        : const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            )),
          );
  }
}
