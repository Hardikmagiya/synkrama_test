// Events
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class TabEvent {}

class TabChanged extends TabEvent {
  final int index;
  TabChanged(this.index);
}

// States
class TabState {
  final int currentIndex;
  TabState(this.currentIndex);
}

// BLoC
class TabBloc extends Cubit<TabState> {
  TabBloc() : super(TabState(0));

  static TabBloc get(context) => BlocProvider.of(context);
  onTabChange(int? index){
    emit(TabState(index ?? 0));
  }
}
