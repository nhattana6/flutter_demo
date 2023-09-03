import 'package:flutter_bloc/flutter_bloc.dart';

import '../Services/EventApiProvider.dart';
import 'event_event.dart';
import 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final ApiProvider _eventRepository;

  EventBloc(this._eventRepository) : super(EventLoadingState()) {
    on<LoadEventEvent>((event, emit) async {
      emit(EventLoadingState());
      try {
        final joke = await _eventRepository.fetchEventList();
        emit(EventLoadedState(joke));
      } catch (e) {
        emit(EventErrorState(e.toString()));
      }
    });
  }
}