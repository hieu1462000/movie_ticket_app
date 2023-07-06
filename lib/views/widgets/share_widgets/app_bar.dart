import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final VoidCallback leadingOnnClick;
  final Widget leadingWidget;
  final Widget titleWidget;
  final bool isCenter;
  final FlexibleSpaceBar? flexibleSpaceBar;
  final double expandedHeight;

  const AppBarWidget(
      {Key? key,
      required this.leadingWidget,
      required this.leadingOnnClick,
      required this.titleWidget,
      required this.isCenter,
      this.flexibleSpaceBar,
      required this.expandedHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: InkWell(onTap: leadingOnnClick, child: leadingWidget),
      backgroundColor: Colors.black,
      expandedHeight: expandedHeight,
      centerTitle: isCenter,
      elevation: 0,
      floating: true,
      title: titleWidget,
      pinned: true,
      snap: false,
      flexibleSpace: flexibleSpaceBar,
    );
  }
}
