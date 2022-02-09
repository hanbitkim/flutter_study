import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GalleryPageState();
  }
}

class _GalleryPageState extends State<GalleryPage> {
  late List<String> _images;
  late int _index;
  late PageController _pageController;

  @override
  void initState() {
    final _params = Get.arguments as GalleryParams;
    _images = _params.images;
    _index = _params.index;
    _pageController = PageController(
      initialPage: _params.index
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (context, index) => _buildItem(_images[index], index),
            itemCount: _images.length,
            pageController: _pageController,
            onPageChanged: (index) => setState(() {
              _index = index;
            }),
            scrollDirection: Axis.horizontal,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DotsIndicator(
              dotsCount: _images.length,
              position: _index.toDouble(),
            ),
          )
        ],
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(String path, int index) {
    return PhotoViewGalleryPageOptions.customChild(
      child: CachedNetworkImage(
        imageUrl: path,
        fit: BoxFit.contain,
      ),
      initialScale: PhotoViewComputedScale.covered,
      minScale: PhotoViewComputedScale.covered * 1,
      maxScale: PhotoViewComputedScale.covered * 3,
      heroAttributes: PhotoViewHeroAttributes(tag: path),
      scaleStateCycle: myScaleStateCycle
    );
  }

  PhotoViewScaleState myScaleStateCycle(PhotoViewScaleState actual) {
    switch (actual) {
      case PhotoViewScaleState.initial:
        return PhotoViewScaleState.zoomedIn;
      default:
        return PhotoViewScaleState.initial;
    }
  }
}

class GalleryParams {
  List<String> images;
  int index;

  GalleryParams({
    required this.images, required this.index
  });
}