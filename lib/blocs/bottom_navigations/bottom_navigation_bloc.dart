import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(const BottomNavigationInitial(tabIndex: 0)) {
    on<TabChange>((event, emit) {
      emit(BottomNavigationInitial(tabIndex: event.tabIndex));
    });
  }
}
