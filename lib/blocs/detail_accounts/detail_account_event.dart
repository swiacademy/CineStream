part of 'detail_account_bloc.dart';

sealed class DetailAccountEvent extends Equatable {
  const DetailAccountEvent();

  @override
  List<Object> get props => [];
}

class GetDetailAccount extends DetailAccountEvent {}
