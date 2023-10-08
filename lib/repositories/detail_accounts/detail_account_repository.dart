import 'package:movies_apps_bloc_pattern/models/detail_account_model.dart';

abstract class DetailAccountRepository {
  Future<DetailAccountModel> getAccountDetail();
}
