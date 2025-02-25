import 'package:flutter/material.dart';

/// App Bar widget for whole project
class BikeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BikeAppBar({super.key, this.subTitle, required this.title});

  /// Subtitle of the app bar
  final String? subTitle;

  /// Title of the app bar
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(title),
          if (subTitle != null) Text(subTitle!),
        ],
      ),
    );
  }
}
