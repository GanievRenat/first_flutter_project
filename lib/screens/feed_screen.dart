import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';

const String kFlutterDash =
    'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Photo',
          style: AppStyles.h1Black.copyWith(
            color: AppColors.black,
          ),
        ),
        backgroundColor: AppColors.white,
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            _buildItem(),
            Divider(thickness: 2, color: AppColors.mercury),
          ],
        );
      }),
    );
  }

  Widget _buildItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Photo(
          photoLink: kFlutterDash,
        ),
        _buildPhotoMeta(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            'Тестовый текст описания',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.h3,
          ),
        )
      ],
    );
  }
}

Widget _buildPhotoMeta() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: <Widget>[
            UserAvatar('https://sun9-11.userapi.com/c846217/v846217468/9f056/6yiX9CTwo4k.jpg'),
            SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Ganiev Renat',
                  style: AppStyles.h2Black,
                ),
                Text(
                  '@inkognitum',
                  style: AppStyles.h5Black.copyWith(
                    color: AppColors.manatee,
                  ),
                ),
              ],
            ),
          ],
        ),
        LikeButton(10, true),
      ],
    ),
  );
}
