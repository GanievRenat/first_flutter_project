import 'package:FlutterGalleryApp/screens/photo_screen.dart';
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
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: AppColors.white,
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenImage(
                      name: 'Ganiev Renat',
                      userName: 'inkognitum',
                      altDescription: 'Тестовое описание',
                      photo: kFlutterDash,
                      heroTag: 'photo_${index}',
                    ),
                  ),
                );
              },
              child: _buildItem(index: index),
            ),
            Divider(thickness: 2, color: AppColors.mercury),
          ],
        );
      }),
    );
  }

  Widget _buildItem({int index}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(
          tag: 'photo_${index}',
          child: Photo(
            photoLink: kFlutterDash,
          ),
        ),
        _buildPhotoMeta(context),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            'Тестовый текст описания',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline3,
          ),
        )
      ],
    );
  }
}

Widget _buildPhotoMeta(BuildContext context) {
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
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  '@inkognitum',
                  style: Theme.of(context).textTheme.headline5,
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
