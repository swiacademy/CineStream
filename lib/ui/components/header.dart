import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.080,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: Row(
              children: [
                Image.asset((Theme.of(context).brightness == Brightness.dark
                    ? "assets/images/cinestream_w.png"
                    : "assets/images/cinestream_b.png")),
                Text(
                  "Welcome, ${Constans.USER_NAME}".toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black87),
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 30,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.indigo, width: 3)),
                child: ClipOval(
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(imageUrl: Constans.IMAGE_PROFILE),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
