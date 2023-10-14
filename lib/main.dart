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
import 'package:movies_apps_bloc_pattern/ui/components/bottom_bar_navigation.dart';
import 'package:movies_apps_bloc_pattern/ui/pages/detail_movies_page.dart';
import 'package:movies_apps_bloc_pattern/ui/pages/favorite_movies_page.dart';
import 'package:movies_apps_bloc_pattern/ui/pages/home_movies_page.dart';
import 'package:movies_apps_bloc_pattern/ui/pages/login_movies_page.dart';
import 'package:movies_apps_bloc_pattern/ui/pages/profile_page.dart';
import 'package:movies_apps_bloc_pattern/ui/pages/trailer_movies_page.dart';
import 'package:movies_apps_bloc_pattern/ui/pages/watchlist_movies_page.dart';
import 'package:movies_apps_bloc_pattern/utils/constants.dart';

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
        // GetPage with custom transitions and bindings
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

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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

              return Scaffold(
                resizeToAvoidBottomInset: false,
                bottomNavigationBar: const BottomBarNavigationComponent(),
                body: BlocConsumer<BottomNavigationBloc, BottomNavigationState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    // return IndexedStack(
                    //   index: state.tabIndex,
                    //   children: widgetScreen,
                    // );
                    return widgetScreen.elementAt(state.tabIndex);
                  },
                ),
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
                bottomNavigationBar: BottomBarNavigationComponent(),
                body: HomeMoviesPage(),
              );
            }

            if (state is AuthMoviesErrorState) {
              return const Text("Error Page");
            }

            return Container();
          },
        ),
      ),
    );
  }
}
