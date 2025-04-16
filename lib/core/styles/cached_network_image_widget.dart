import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:short_path/core/styles/animations/app_animation.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double height;
  final double width;
  final BoxFit? fit;

  const CachedNetworkImageWidget(
      {super.key,
      required this.imageUrl,
      required this.width,
      required this.height,
      this.fit});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit,
      height: height.h,
      width: width.w,
      imageUrl: imageUrl!,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Lottie.asset(
        AppAnimation.loading,
        height: 50,
        width: 50,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
