import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DetailTicketBackground extends StatelessWidget {
  final Widget content;
  const DetailTicketBackground({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final ticketWidth = 90.w;
    final ticketHeight = 85.h;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: SizedBox(
        width: ticketWidth,
        height: ticketHeight,
        child: ClipPath(
          clipper: TicketClipper(
              smallCircleClipPadding: 5.w,
              borderRadius: 10,
              bigCircleClipRadius: 4.w,
              smallCircleClipRadius: 1.5.w,
              numberOfSmallCircleClips: 13,
              numberOfRecClips: 4,
              recClipPadding: 9.w,
              recClipHeight: 3.w,
              recClipWidth: 14.w),
          child: Container(
            color: Colors.white.withOpacity(0.8),
            child: content,
          ),
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  final double smallCircleClipPadding;
  final double borderRadius;
  final double bigCircleClipRadius;
  final double smallCircleClipRadius;
  final int numberOfSmallCircleClips;

  final int numberOfRecClips;
  final double recClipPadding;
  final double recClipHeight;
  final double recClipWidth;

  const TicketClipper(
      {required this.smallCircleClipPadding,
      required this.borderRadius,
      required this.bigCircleClipRadius,
      required this.smallCircleClipRadius,
      required this.numberOfSmallCircleClips,
      required this.numberOfRecClips,
      required this.recClipPadding,
      required this.recClipHeight,
      required this.recClipWidth});

  @override
  Path getClip(Size size) {
    var path = Path();

    final clipCenterY = size.height * 0.3 + bigCircleClipRadius;

    // draw rect
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    ));

    final clipPath = Path();

    // circle on the left
    clipPath.addOval(Rect.fromCircle(
      center: Offset(0, clipCenterY),
      radius: bigCircleClipRadius,
    ));

    // circle on the right
    clipPath.addOval(Rect.fromCircle(
      center: Offset(size.width, clipCenterY),
      radius: bigCircleClipRadius,
    ));

    // draw small clip circles, each small circle clip inside one clipbox
    final smallClipContainerSize =
        size.width - bigCircleClipRadius * 2 - smallCircleClipPadding * 2;
    final smallClipSize = smallCircleClipRadius * 2;
    final smallClipBoxSize = smallClipContainerSize / numberOfSmallCircleClips;
    final smallClipBoxPadding =
        (smallClipBoxSize - smallClipSize) / 2; // small circle inside clipbox
    final smallClipBoxStart = bigCircleClipRadius +
        smallCircleClipPadding; // space between first circle and first clipbox that contain small circle

    final smallClipCenterOffsets =
        List.generate(numberOfSmallCircleClips, (index) {
      final boxX = smallClipBoxStart + smallClipBoxSize * index;
      final centerX = boxX + smallClipBoxPadding + smallCircleClipRadius;

      return Offset(centerX, clipCenterY);
    });

    smallClipCenterOffsets.forEach((centerOffset) {
      clipPath.addOval(Rect.fromCircle(
        center: centerOffset,
        radius: smallCircleClipRadius,
      ));
    });

    // draw clip rec
    final recClipContainerSize =
        size.width - 2 * recClipPadding; //size of box container all clips
    final recClipBoxSize = recClipContainerSize /
        numberOfRecClips; //size of each clipbox that contain one rec clip
    final recClipBoxPadding = (recClipBoxSize - recClipWidth) / 2;

    // Rectangle clip
    final smallClipTopOffsets = List.generate(numberOfRecClips, (index) {
      final boxX = recClipPadding + recClipBoxSize * index;
      final centerX = boxX + recClipBoxPadding + recClipWidth / 2;

      return Offset(centerX, 0);
    });

    smallClipTopOffsets.forEach((centerOffset) {
      // clipPath.addRect(Rect.fromCenter(
      //     center: centerOffset, width: recClipWidth, height: recClipHeight)); //without radius
      clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: centerOffset, width: recClipWidth, height: recClipHeight),
        Radius.circular(7), //with radius
      ));
    });

    final smallClipBottomOffsets = List.generate(numberOfRecClips, (index) {
      final boxX = recClipPadding + recClipBoxSize * index;
      final centerX = boxX + recClipBoxPadding + recClipWidth / 2;

      return Offset(centerX, size.height);
    });

    smallClipBottomOffsets.forEach((centerOffset) {
      clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: centerOffset, width: recClipWidth, height: recClipHeight),
        Radius.circular(7),
      ));
    });

    // combine two path together
    final ticketPath = Path.combine(
      PathOperation.reverseDifference,
      clipPath,
      path,
    );

    return ticketPath;
  }

  @override
  bool shouldReclip(TicketClipper oldClipper) =>
      oldClipper.smallCircleClipPadding != smallCircleClipPadding ||
      oldClipper.borderRadius != borderRadius ||
      oldClipper.bigCircleClipRadius != bigCircleClipRadius ||
      oldClipper.smallCircleClipRadius != smallCircleClipRadius ||
      oldClipper.numberOfSmallCircleClips != numberOfSmallCircleClips ||
      oldClipper.numberOfRecClips != numberOfRecClips ||
      oldClipper.recClipPadding != recClipPadding ||
      oldClipper.recClipHeight != recClipHeight ||
      oldClipper.recClipWidth != recClipWidth;
}
