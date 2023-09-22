import 'package:flutter_bloc/flutter_bloc.dart';

import '../Services/EventApiProvider.dart';
import 'event_details_event.dart';
import 'event_details_state.dart';

class EventDetailBloc extends Bloc<EventDetailsEvent, EventDetailsState> {
  final ApiProvider _eventRepository;

  EventDetailBloc(this._eventRepository) : super(EventDetailsLoadingState()){
    on<LoadEventDetailsEvent>((event, emit) async {
      emit(EventDetailsLoadingState());
      try {
        final joke = await _eventRepository.fetchEventDetails(event.id);
        emit(EventDetailsLoadedState(joke));
      } catch (e) {
        emit(EventDetailsErrorState(e.toString()));
      }
    });

    on<LoadAddNewEvent>((event, emit) async {
      emit(EventDetailsAddedState());
      try {
        final joke = await _eventRepository.createNewEvent(event.event);
        emit(EventAddedState(joke));
      } catch (e) {
        emit(EventDetailsErrorState(e.toString()));
      }
    });

    on<LoadDeleteEvent>((event, emit) async {
      emit(EventDetailsLoadingState());
      try {
        final joke = await _eventRepository.deleteEvent(event.id);
        emit(EventDeleteLoadedState(joke));
      } catch (e) {
        emit(EventDetailsErrorState(e.toString()));
      }
    });
  }
}