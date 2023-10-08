import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:movies_apps_bloc_pattern/blocs/auth_movies/auth_movies_bloc.dart';
import 'package:movies_apps_bloc_pattern/ui/components/label.dart';
import 'package:movies_apps_bloc_pattern/utils/constants.dart';
import '../../repositories/login_movies/login_movies_impl.dart';

class LoginMoviesPage extends StatefulWidget {
  const LoginMoviesPage({super.key});

  @override
  State<LoginMoviesPage> createState() => _LoginMoviesPageState();
}

class _LoginMoviesPageState extends State<LoginMoviesPage> {
  late TextEditingController userNameController, passwordController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return RepositoryProvider(
      create: (context) => LoginMoviesImpl(),
      child: Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: Stack(
                    children: [
                      Positioned(
                        width: MediaQuery.of(context).size.width,
                        bottom: 100,
                        child: Image.asset(
                          (Theme.of(context).brightness == Brightness.dark
                              ? "assets/images/cinestream_w.png"
                              : "assets/images/cinestream_b.png"),
                          height: 320,
                        ),
                      ),
                      Positioned(
                        width: MediaQuery.of(context).size.width * 0.8,
                        bottom: 30,
                        child: Text(
                          Constans.APP_TAGLINE,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Label(text: Constans.LABEL_LOGIN_ACCOUNT),
                ),
                FormBuilder(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: FormBuilderTextField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: Constans.LABEL_LOGIN_USERNAME),
                            name: 'username',
                            controller: userNameController,
                            enableInteractiveSelection: true,
                            onChanged: (val) {},
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: FormBuilderTextField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: Constans.LABEL_LOGIN_PASSWORD),
                            name: 'password',
                            controller: passwordController,
                            obscureText: true,
                            enableInteractiveSelection: true,
                            onChanged: (val) {},
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color(0XFF4D2DB7))),
                            onPressed: () {
                              BlocProvider.of<AuthMoviesBloc>(context).add(
                                  LoggedIn(userNameController.text,
                                      passwordController.text));
                            },
                            child: Text(
                              Constans.LABEL_LOGIN_SIGN_IN,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                            )),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        Constans.LABEL_LOGIN_OR,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black87)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.black87)),
                          onPressed: () {
                            BlocProvider.of<AuthMoviesBloc>(context)
                                .add(SkipLoggedIn());
                          },
                          child: Text(Constans.LABEL_LOGIN_BROWSE_MOVIE,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
