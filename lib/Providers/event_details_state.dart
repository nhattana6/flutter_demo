import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:new_first_demo/Models/event.dart';

@immutable
abstract class EventDetailsState extends Equatable {
  get event => Event;
  get loading => false;
  get isDelete => false;
  get isAdded => false;
  get isLoadingAdded => false;
}

class EventDetailsLoadingState extends EventDetailsState {
  @override
  final bool loading = true;

  @override
  List<Object?> get props => [];
}

class EventDetailsAddedState extends EventDetailsState {
  @override
  final bool isLoadingAdded = true;

  @override
  List<Object?> get props => [];
}

class EventDetailsLoadedState extends EventDetailsState {
  @override
  final Event? event;

  EventDetailsLoadedState(this.event);

  @override
  List<Object?> get props => [event];
}

class EventAddedState extends EventDetailsState {
  @override
  final bool isLoadingAdded = false;

  @override
  final bool isAdded = true;

  @override
  final Event? event;

  EventAddedState(this.event);

  @override
  List<Object?> get props => [event];
}

class EventDeleteLoadedState extends EventDetailsState {
  @override
  final Event? event;

  @override
  final bool isDelete = true;

  EventDeleteLoadedState(this.event);

  @override
  List<Object?> get props => [event];
}

class EventDetailsErrorState extends EventDetailsState {
  final String error;

  EventDetailsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}