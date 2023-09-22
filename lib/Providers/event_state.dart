import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:new_first_demo/Models/event.dart';

@immutable
abstract class EventState extends Equatable {
  get eventList => [];
  get loading => false;
  get location => '';
}

class EventLoadingState extends EventState {
  @override
  final bool loading = true;

  @override
  List<Object?> get props => [];
}

class EventLoadedState extends EventState {
  @override
  final String? location;
  @override
  final List<Event?> eventList;

  EventLoadedState(this.eventList, this.location);

  @override
  List<Object?> get props => [eventList];
}

class EventErrorState extends EventState {
  final String error;

  EventErrorState(this.error);

  @override
  List<Object?> get props => [error];
}