import 'package:flutter/material.dart';
import 'package:paisa/config/themes/app_themes.dart';

Widget buildCircularImage(String imageUrl, double width, double height) {
  return ClipOval(
    child: Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        }
      },
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.error_outline),
    ),
  );
}
