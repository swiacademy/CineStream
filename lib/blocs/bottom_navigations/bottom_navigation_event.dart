part of 'bottom_navigation_bloc.dart';

sealed class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

class TabChange extends BottomNavigationEvent {
  final int tabIndex;

  const TabChange({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}
