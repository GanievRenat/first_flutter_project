import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/res/res.dart';

class UserAvatar extends StatelessWidget {
  final String avatarLink;

  UserAvatar(this.avatarLink);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(50.0),
      ),
      child: CachedNetworkImage(
        imageUrl: avatarLink,
        fit: BoxFit.cover,
        width: 40,
        height: 40,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Center(
          child: Icon(Icons.error),
        ),
      ),
    );
  }
}
