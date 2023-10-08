part of 'detail_account_bloc.dart';

sealed class DetailAccountState extends Equatable {
  const DetailAccountState();

  @override
  List<Object> get props => [];
}

final class DetailAccountLoadingState extends DetailAccountState {}

final class DetailAccountLoadedState extends DetailAccountState {
  final DetailAccountModel detailAccountModel;

  const DetailAccountLoadedState(this.detailAccountModel);

  @override
  List<Object> get props => [detailAccountModel];
}

final class DetailAccountErrorState extends DetailAccountState {
  final String error;

  const DetailAccountErrorState(this.error);

  @override
  List<Object> get props => [error];
}
