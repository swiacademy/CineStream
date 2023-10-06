import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomBarNavigationComponent extends StatefulWidget {
  const BottomBarNavigationComponent({super.key});

  @override
  State<BottomBarNavigationComponent> createState() =>
      _BottomBarNavigationComponentState();
}

class _BottomBarNavigationComponentState
    extends State<BottomBarNavigationComponent> {
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      backgroundColor: (Theme.of(context).brightness == Brightness.dark
          ? Colors.black54
          : Colors.white),
      currentIndex: _currentIndex,
      onTap: (i) => setState(() => _currentIndex = i),
      items: [
        /// Home
        SalomonBottomBarItem(
          icon: Icon(
            Icons.home,
            color: (Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : const Color(0XFF4D2DB7)),
          ),
          title: const Text("Home"),
          selectedColor: (Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : const Color(0XFF4D2DB7)),
        ),

        /// Likes
        SalomonBottomBarItem(
          icon: Icon(
            Icons.favorite_border,
            color: (Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : const Color(0XFF4D2DB7)),
          ),
          title: const Text("Favorites"),
          selectedColor: (Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : const Color(0XFF4D2DB7)),
        ),

        /// Search
        SalomonBottomBarItem(
          icon: Icon(
            Icons.tv,
            color: (Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : const Color(0XFF4D2DB7)),
          ),
          title: const Text("Watchlist"),
          selectedColor: (Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : const Color(0XFF4D2DB7)),
        ),

        /// Profile
        SalomonBottomBarItem(
          icon: Icon(
            Icons.person,
            color: (Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : const Color(0XFF4D2DB7)),
          ),
          title: const Text("Profile"),
          selectedColor: (Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : const Color(0XFF4D2DB7)),
        ),
      ],
    );
  }
}
