import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_apps_mvvm/ui/components/label.dart';
import 'package:movies_apps_mvvm/utils/constants.dart';

class CastMovies extends StatelessWidget {
  final String? profilePath;
  final String? name;
  final String? character;

  const CastMovies(this.profilePath, this.name, this.character, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 45,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.indigo, width: 2)),
            child: ClipOval(
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                  width: 185,
                  placeholderFadeInDuration: const Duration(seconds: 6),
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  fit: BoxFit.cover,
                  imageUrl:
                      "${Constans.API_BASE_URL_PROFILE_W185}$profilePath"),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Label(
          text: name,
        ),
        Text("$character")
      ],
    );
  }
}
