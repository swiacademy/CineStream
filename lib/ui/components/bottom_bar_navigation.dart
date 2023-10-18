import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_apps_bloc_pattern/blocs/bottom_navigations/bottom_navigation_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomBarNavigationComponent extends StatefulWidget {
  const BottomBarNavigationComponent({super.key});

  @override
  State<BottomBarNavigationComponent> createState() =>
      _BottomBarNavigationComponentState();
}

class _BottomBarNavigationComponentState
    extends State<BottomBarNavigationComponent> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavigationBloc, BottomNavigationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SalomonBottomBar(
          backgroundColor: (Theme.of(context).brightness == Brightness.dark
              ? Colors.black54
              : Colors.white),
          currentIndex: state.tabIndex,
          onTap: (i) {
            BlocProvider.of<BottomNavigationBloc>(context)
                .add(TabChange(tabIndex: i));
          },
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
      },
    );
  }
}
