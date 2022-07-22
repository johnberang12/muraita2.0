import 'package:flutter/material.dart';
import 'package:muraita_2_0/src/constants/app_colors.dart';

import '../constants/strings.dart';
import 'custom_image.dart';

class ProfileAvatarWithIndicator extends StatelessWidget {
  const ProfileAvatarWithIndicator(
      {Key? key, required this.imageUrl, required this.isActive})
      : super(key: key);
  final String imageUrl;

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        ClipOval(
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: imageUrl != ''
                ? CustomImage(
                    imageUrl: imageUrl,
                  )
                : Image.asset(kDefaultUserProfile),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 8,
            child: Icon(
              Icons.offline_pin,
              color: isActive ? AppColors.activeColor : null,
              size: 15,
            ),
          ),
        )
      ],
    );
  }
}
