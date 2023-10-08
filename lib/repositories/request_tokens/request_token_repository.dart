import 'package:movies_apps_bloc_pattern/models/request_token_model.dart';

abstract class RequestTokenRepository {
  Future<RequestTokenModel> getRequestToken();
}
