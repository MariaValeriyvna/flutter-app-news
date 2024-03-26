import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    this.height = 125,
    this.borderRadius = 20,
    required this.width,
    required this.urlToImage,
    this.padding,
    this.margin,
    this.child,
  });

  final double width;
  final double height;
  final String urlToImage;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      // child: CachedNetworkImage(
      //   imageUrl: urlToImage,
      //     imageBuilder: (context, imageProvider) => Container(
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(20),
      //       color: Colors.black26,
      //     image: urlToImage.isNotEmpty ? DecorationImage(
      //       image: imageProvider,
      //       fit: BoxFit.cover)
      //        : const DecorationImage(
      //     image: AssetImage('assets/no_image.png'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      //   ),
      //   placeholder: (context, url) => const CircularProgressIndicator(),
      //   errorWidget: (context, url, error) => const Icon(Icons.error),
      //   ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black26,
        image: urlToImage.isNotEmpty ? DecorationImage(
          image: NetworkImage(urlToImage),
          fit: BoxFit.cover,
        ) : const DecorationImage(
          image: AssetImage('assets/no_image.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
