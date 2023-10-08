import 'package:movies_apps_bloc_pattern/models/auth_session_model.dart';
import 'package:movies_apps_bloc_pattern/models/validation_token_model.dart';

abstract class LoginMoviesRepository {
  Future<bool> getIsLoggedIn();
  Future<bool> skipLoggenIn();
  Future<void> saveSessionId(String sessionId);
  Future<void> setSkipLogin();
  Future<void> getSkipLogin();
  Future<AuthSessionModel> createSession(String username, String password);
  Future<ValidationTokenModel> validationToken(
      String requestToken, String username, String password);
}
