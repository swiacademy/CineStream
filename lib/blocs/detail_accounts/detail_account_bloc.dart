import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_apps_bloc_pattern/models/detail_account_model.dart';
import 'package:movies_apps_bloc_pattern/repositories/detail_accounts/detail_account_impl.dart';

part 'detail_account_event.dart';
part 'detail_account_state.dart';

class DetailAccountBloc extends Bloc<DetailAccountEvent, DetailAccountState> {
  final DetailAccountImpl detailAccountImpl;

  DetailAccountBloc(this.detailAccountImpl)
      : super(DetailAccountLoadingState()) {
    on<GetDetailAccount>((event, emit) async {
      emit(DetailAccountLoadingState());

      try {
        final detailAccount = await detailAccountImpl.getAccountDetail();
        emit(DetailAccountLoadedState(detailAccount));
      } catch (e) {
        emit(DetailAccountErrorState(e.toString()));
      }
    });
  }
}
