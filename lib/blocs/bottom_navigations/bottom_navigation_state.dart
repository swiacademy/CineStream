part of 'bottom_navigation_bloc.dart';

sealed class BottomNavigationState extends Equatable {
  final int tabIndex;
  const BottomNavigationState({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}

final class BottomNavigationInitial extends BottomNavigationState {
  const BottomNavigationInitial({required super.tabIndex});
}
