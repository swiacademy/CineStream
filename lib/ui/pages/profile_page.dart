import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_apps_bloc_pattern/blocs/auth_movies/auth_movies_bloc.dart';
import 'package:movies_apps_bloc_pattern/blocs/detail_accounts/detail_account_bloc.dart';
import 'package:movies_apps_bloc_pattern/repositories/detail_accounts/detail_account_impl.dart';

import '../../utils/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailAccountBloc(RepositoryProvider.of<DetailAccountImpl>(context))
            ..add(GetDetailAccount()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: Column(
          children: [
            BlocBuilder<DetailAccountBloc, DetailAccountState>(
              builder: (context, state) {
                if (state is DetailAccountLoadingState) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (state is DetailAccountLoadedState) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 12, top: 8, right: 16),
                    child: Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
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
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    imageUrl:
                                        "https://secure.gravatar.com/avatar/${state.detailAccountModel.avatar?.gravatar!.hash}.jpg?s=128"),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "${state.detailAccountModel.name}",
                            style: const TextStyle(fontSize: 22.0),
                          ),
                          Text(
                            "@${state.detailAccountModel.username.toString()}",
                            style: const TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (state is DetailAccountErrorState) {
                  return Center(child: Text(state.error));
                }

                return Container();
              },
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () =>
                      {context.read<AuthMoviesBloc>().add(Signout())},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 30))),
                  child: Text(Constants.LABEL_LOGIN_SIGN_OUT,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white))),
            )
          ],
        ),
      ),
    );
  }
}
