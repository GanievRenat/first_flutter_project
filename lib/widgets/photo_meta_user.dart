import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter/material.dart';

class PhotoMetaUser extends StatelessWidget {
  PhotoMetaUser({this.controller, this.name, this.nikName, Key key})
      : opacityUserAvatar = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.5,
              curve: Curves.ease,
            ),
          ),
        ),
        opacityUserName = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              1.0,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<double> opacityUserAvatar;
  final Animation<double> opacityUserName;
  final String name;
  final String nikName;

  Widget _buildPhotoMeta(BuildContext context, Widget child) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: <Widget>[
              Opacity(
                opacity: opacityUserAvatar.value,
                child: UserAvatar('https://sun9-11.userapi.com/c846217/v846217468/9f056/6yiX9CTwo4k.jpg'),
              ),
              SizedBox(width: 6),
              Opacity(
                opacity: opacityUserName.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      (name != null) ? name : '',
                      style: AppStyles.h1Black,
                    ),
                    Text(
                      (nikName != null) ? '@${nikName}' : '',
                      style: AppStyles.h5Black.copyWith(
                        color: AppColors.manatee,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildPhotoMeta,
      animation: controller,
    );
  }
}
