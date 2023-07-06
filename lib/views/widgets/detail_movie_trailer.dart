import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:sizer/sizer.dart';

class MovieTrailer extends StatefulWidget {
  final String trailerId;
  final String posterPath;
  final String title;
  final String releaseDate;
  final int runtime;
  final String overview;

  const MovieTrailer(
      {Key? key,
      required this.trailerId,
      required this.posterPath,
      required this.title,
      required this.releaseDate,
      required this.runtime,
      required this.overview})
      : super(key: key);

  @override
  State<MovieTrailer> createState() => _MovieTrailerState();
}

class _MovieTrailerState extends State<MovieTrailer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.trailerId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 36.h,
          width: 100.w,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 25.h,
                    child: YoutubePlayer(
                      width: 100.w,
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.white,
                      progressColors: const ProgressBarColors(
                        playedColor: Colors.white,
                        handleColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  height: 22.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          child: Image.network(
                            widget.posterPath,
                            height: 22.h,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.w),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 11.h,
                                ),
                                SizedBox(
                                  width: 60.w,
                                  child: Text(
                                    widget.title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.sp),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.w,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(
                                          right: 2.w,
                                          left: 2.w,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_today,
                                              size: 14,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Text(
                                              widget.releaseDate,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11.sp),
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        right: 2.w,
                                        left: 2.w,
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.timelapse,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 1.w,
                                          ),
                                          Text(
                                            "${widget.runtime} minutes",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11.sp),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ]),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(3.w),
          width: 98.w,
          child: Text(
            widget.overview,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            style: TextStyle(color: Colors.grey, fontSize: 11.sp),
          ),
        ),
      ],
    );
  }
}
