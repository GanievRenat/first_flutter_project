import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/res/res.dart';

class Photo extends StatelessWidget {
  final String photoLink;

  Photo({Key key, this.photoLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(17.0),
        ),
        child: Container(
          color: AppColors.grayChateau,
          child: CachedNetworkImage(
            imageUrl: photoLink,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Center(
              child: Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
