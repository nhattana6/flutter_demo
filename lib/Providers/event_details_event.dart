import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:new_first_demo/Models/event.dart';

@immutable
abstract class EventDetailsEvent extends Equatable {
  const EventDetailsEvent();
}

class LoadEventDetailsEvent extends EventDetailsEvent {
  final int id;
  const LoadEventDetailsEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class LoadAddNewEvent extends EventDetailsEvent {
  final Event event;
  const LoadAddNewEvent(this.event);

  @override
  // TODO: implement props
  List<Object?> get props => [event];
}

class LoadDeleteEvent extends EventDetailsEvent {
  final int id;
  const LoadDeleteEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}