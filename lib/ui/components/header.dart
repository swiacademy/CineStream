import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_apps_bloc_pattern/blocs/auth_movies/auth_movies_bloc.dart';
import 'package:movies_apps_bloc_pattern/blocs/detail_accounts/detail_account_bloc.dart';
import 'package:movies_apps_bloc_pattern/repositories/login_movies/login_movies_impl.dart';

import '../../utils/constants.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => LoginMoviesImpl()),
        // RepositoryProvider(create: (context) => DetailAccountImpl())
      ],
      child: Container(
        padding: const EdgeInsets.all(2.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Image.asset(
                    (Theme.of(context).brightness == Brightness.dark
                        ? "assets/images/cinestream_w.png"
                        : "assets/images/cinestream_b.png"),
                    width: 100,
                  ),
                ],
              ),
            ),
            BlocBuilder<AuthMoviesBloc, AuthMoviesState>(
              builder: (context, state) {
                if (state is AuthMoviesSkipAuthenticatedState) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Text(
                        Constants.LABEL_LOGIN_SIGN_IN,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        BlocProvider.of<AuthMoviesBloc>(context)
                            .add(GetIsLoggedIn());
                      },
                    ),
                  );
                }

                if (state is AuthMoviesAuthenticatedState) {
                  return SizedBox(
                    child: BlocBuilder<DetailAccountBloc, DetailAccountState>(
                      builder: (context, state) {
                        if (state is DetailAccountLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (state is DetailAccountLoadedState) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Welcome, ${state.detailAccountModel.username}"
                                    .toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black87),
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: CircleAvatar(
                                  radius: 22,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.indigo, width: 3)),
                                    child: ClipOval(
                                      clipBehavior: Clip.antiAlias,
                                      child: CachedNetworkImage(
                                          placeholderFadeInDuration:
                                              const Duration(seconds: 6),
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          imageUrl:
                                              "https://secure.gravatar.com/avatar/${state.detailAccountModel.avatar?.gravatar!.hash}.jpg?s=128"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        if (state is DetailAccountErrorState) {
                          return const Text("Error fetch data....");
                        }

                        return Container();
                      },
                    ),
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
