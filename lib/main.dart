import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:movies_apps_bloc_pattern/blocs/auth_movies/auth_movies_bloc.dart';
import 'package:movies_apps_bloc_pattern/blocs/bottom_navigations/bottom_navigation_bloc.dart';
import 'package:movies_apps_bloc_pattern/blocs/detail_accounts/detail_account_bloc.dart';
import 'package:movies_apps_bloc_pattern/repositories/detail_accounts/detail_account_impl.dart';
import 'package:movies_apps_bloc_pattern/repositories/login_movies/login_movies_impl.dart';
import 'package:movies_apps_bloc_pattern/repositories/now_playing_movies/now_playing_movies_impl.dart';
import 'package:movies_apps_bloc_pattern/repositories/popular_movies/popular_movies_impl.dart';
import 'package:movies_apps_bloc_pattern/repositories/upcoming_movies/upcoming_movies_impl.dart';
import 'package:movies_apps_bloc_pattern/ui/pages/detail_movies_page.dart';
import 'package:movies_apps_bloc_pattern/ui/pages/favorite_movies_page.dart';
import 'package:movies_apps_bloc_pattern/ui/pages/home_movies_page.dart';
import 'package:movies_apps_bloc_pattern/ui/pages/login_movies_page.dart';
import 'package:movies_apps_bloc_pattern/ui/pages/profile_page.dart';
import 'package:movies_apps_bloc_pattern/ui/pages/trailer_movies_page.dart';
import 'package:movies_apps_bloc_pattern/ui/pages/watchlist_movies_page.dart';
import 'package:movies_apps_bloc_pattern/utils/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        //Simple GetPage
        GetPage(name: '/login', page: () => const LoginMoviesPage()),
        GetPage(name: '/home-movie', page: () => const HomeMoviesPage()),
        GetPage(name: '/detail-single-movie', page: () => const DetailMovie()),
        GetPage(name: '/trailer-movie', page: () => const TrailerMovie()),
      ],
      title: Constants.APP_NAME,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => DetailAccountImpl()),
          RepositoryProvider(create: (context) => LoginMoviesImpl()),
          RepositoryProvider(create: (context) => UpcomingMoviesImpl()),
          RepositoryProvider(create: (context) => NowPlayingMoviesImpl()),
          RepositoryProvider(create: (context) => PopularMoviesImpl()),
        ],
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentIndex = 0;
  bool isStateManagement = true;
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {});
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthMoviesBloc>(
            create: (context) => AuthMoviesBloc(
                  RepositoryProvider.of<LoginMoviesImpl>(context),
                )..add(GetIsLoggedIn())),
        BlocProvider(
            create: (context) => DetailAccountBloc(
                  RepositoryProvider.of<DetailAccountImpl>(context),
                )..add(GetDetailAccount())),
        BlocProvider(create: (context) => BottomNavigationBloc()),
      ],
      child: Expanded(
        child: BlocBuilder<AuthMoviesBloc, AuthMoviesState>(
          builder: (context, state) {
            // if (state is AuthMoviesDetailAccountState) {
            //   return const Text("Splash Screen");
            // }

            if (state is AuthMoviesAuthenticatedState) {
              const List<Widget> widgetScreen = <Widget>[
                HomeMoviesPage(),
                FavoriteMoviesPage(),
                WatchlistMoviesPage(),
                ProfilePage(),
              ];

              List<PersistentBottomNavBarItem> navBarsItems() {
                return [
                  PersistentBottomNavBarItem(
                    icon: const Icon(Icons.home),
                    title: ("Home"),
                    activeColorPrimary: Colors.grey,
                    activeColorSecondary: Colors.white,
                    inactiveColorPrimary: const Color(0XFF4D2DB7),
                  ),
                  PersistentBottomNavBarItem(
                    icon: const Icon(Icons.favorite_border),
                    title: ("Favorites"),
                    activeColorPrimary: Colors.grey,
                    activeColorSecondary: Colors.white,
                    inactiveColorPrimary: const Color(0XFF4D2DB7),
                  ),
                  PersistentBottomNavBarItem(
                    icon: const Icon(Icons.tv),
                    title: ("Watchlist"),
                    activeColorPrimary: Colors.grey,
                    activeColorSecondary: Colors.white,
                    inactiveColorPrimary: const Color(0XFF4D2DB7),
                  ),
                  PersistentBottomNavBarItem(
                    icon: const Icon(Icons.person),
                    title: ("Profile"),
                    activeColorPrimary: Colors.grey,
                    activeColorSecondary: Colors.white,
                    inactiveColorPrimary: const Color(0XFF4D2DB7),
                  ),
                ];
              }

              return BlocConsumer<BottomNavigationBloc, BottomNavigationState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is BottomNavigationInitial) {
                    debugPrint(state.tabIndex.toString());
                    return PersistentTabView(
                      context,
                      controller: _controller,
                      screens: widgetScreen,
                      items: navBarsItems(),
                      confineInSafeArea: true,
                      backgroundColor: Colors.black, // Default is Colors.white.
                      handleAndroidBackButtonPress: true, // Default is true.
                      resizeToAvoidBottomInset: true,
                      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                      stateManagement: false,
                      hideNavigationBarWhenKeyboardShows:
                          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
                      popAllScreensOnTapOfSelectedTab: false,
                      popActionScreens: PopActionScreensType.all,
                      itemAnimationProperties: const ItemAnimationProperties(
                        // Navigation Bar's items animation properties.
                        duration: Duration(milliseconds: 200),
                        curve: Curves.ease,
                      ),
                      screenTransitionAnimation:
                          const ScreenTransitionAnimation(
                        // Screen transition animation on change of selected tab.
                        animateTabTransition: true,
                        curve: Curves.ease,
                        duration: Duration(milliseconds: 200),
                      ),
                      navBarStyle: NavBarStyle
                          .style1, // Choose the nav bar style with this property.
                    );
                  }

                  return Container();
                },
              );
            }

            if (state is AuthMoviesUnauthenticatedState) {
              return const Scaffold(
                body: LoginMoviesPage(),
              );
            }

            if (state is AuthMoviesSkipAuthenticatedState) {
              return const Scaffold(
                resizeToAvoidBottomInset: false,
                // bottomNavigationBar: BottomBarNavigationComponent(),
                body: HomeMoviesPage(),
              );
            }

            if (state is AuthMoviesErrorState) {
              return const Text("Error Page");
            }

            if (state is AuthSignoutSuccessState) {
              return const Scaffold(
                body: LoginMoviesPage(),
              );
            }

            if (state is AuthSignoutErrorState) {
              return const Text("Error Sign out");
            }
            return Container();
          },
        ),
      ),
    );
  }
}
