import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:gallery_saver/gallery_saver.dart';

const String kFlutterDush =
    'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png';

class FullScreenImage extends StatefulWidget {
  FullScreenImage({this.altDescription, this.userName, this.name, this.photo, this.userPhoto, this.heroTag, Key key})
      : super(key: key);

  final String altDescription;
  final String userName;
  final String name;
  final String photo;
  final String userPhoto;
  final String heroTag;

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<FullScreenImage> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    _playAnimation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await _animationController.forward().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Photo',
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: AppColors.manatee),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.more_vert, color: AppColors.manatee),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: false,
                  builder: (context) => Container(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: ClaimBottomSheet(),
                  ),
                );
              })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: widget.heroTag,
            child: Photo(
              photoLink: (widget.photo != null && widget.photo.isNotEmpty) ? widget.photo : kFlutterDush,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              (widget.altDescription != null) ? widget.altDescription : '',
              textAlign: TextAlign.right,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          PhotoMetaUser(
            controller: _animationController,
            name: widget.name,
            nikName: widget.userName,
            userPhoto: widget.userPhoto,
          ),
          _buildLikeAndButton(context, widget.photo),
        ],
      ),
    );
  }
}

Widget _buildLikeAndButton(BuildContext context, String photo) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Expanded(
        child: Center(
          child: LikeButton(10, true),
        ),
      ),
      Expanded(
        child: Button(
          colour: AppColors.dodgerBlue,
          text: 'Save',
          onPress: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Downloading photos'),
                  content: Text('Are you sure you want to upload a photo?'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Download'),
                      onPressed: () async {
                        GallerySaver.saveImage(photo).then((bool success) {
                          if (success) {
                            Navigator.of(context).pop();
                          }
                        });
                      },
                    ),
                    FlatButton(
                      child: Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      Expanded(
        child: Button(
          colour: AppColors.dodgerBlue,
          text: 'Visit',
          onPress: () {},
        ),
      )
    ],
  );
}

class Button extends StatelessWidget {
  final Color colour;
  final String text;
  final Function onPress;

  Button({@required this.colour, this.text, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              text,
              style: Theme.of(context).textTheme.headline5.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(color: colour, borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}

class UserAvaraWidget extends StatelessWidget {
  // Leave out the height and width so it fills the animating parent

  UserAvaraWidget({this.userPhoto, this.name, this.nikName});

  double opacityUserAvatar = 0.0;
  double opacityUserName = 0.0;

  final String userPhoto;
  final String name;
  final String nikName;

  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: <Widget>[
                  Opacity(
                    opacity: opacityUserAvatar,
                    child: UserAvatar((userPhoto != null && userPhoto.isNotEmpty) ? userPhoto : kFlutterDush),
                  ),
                  SizedBox(width: 6),
                  Opacity(
                    opacity: opacityUserName,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          (name != null) ? name : '',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text(
                          (nikName != null) ? nikName : '',
                          style: Theme.of(context).textTheme.headline5.copyWith(
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
        ),
      );
}

class PhotoMetaUser extends StatelessWidget {
  PhotoMetaUser({this.userPhoto, this.name, this.nikName, this.controller, Key key})
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

  final String userPhoto;
  final String name;
  final String nikName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: opacityUserAvatar,
                      child: child,
                    );
                  },
                  child: UserAvatar((userPhoto != null && userPhoto.isNotEmpty) ? userPhoto : kFlutterDush),
                ),
                SizedBox(width: 6),
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: opacityUserName,
                      child: child,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        (name != null) ? name : '',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        (nikName != null) ? nikName : '',
                        style: Theme.of(context).textTheme.headline5.copyWith(
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
      ),
    );
  }
}
