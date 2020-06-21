import 'package:flutter/material.dart';

class ClaimBottomSheet extends StatelessWidget {
  List<String> listMenu = ['adult', 'harm', 'bully', 'spam', 'copyright', 'hate'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listMenu.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: ListTile(
            title: Text(
              '${listMenu[index]}'.toUpperCase(),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
