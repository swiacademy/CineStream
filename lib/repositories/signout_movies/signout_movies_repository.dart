import 'package:movies_apps_bloc_pattern/models/signout_model.dart';

abstract class SignoutMoviesRepository {
  Future<SignoutModel> getSignout();
  Future<void> removeSessionId(String sessionId);
}
