import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:new_first_demo/Models/event.dart';

@immutable
abstract class EventState extends Equatable {
  get eventList => [];
  get loading => false;
}

class EventLoadingState extends EventState {
  @override
  final bool loading = true;

  @override
  List<Object?> get props => [];
}

class EventLoadedState extends EventState {
  @override
  final List<Object> eventList;

  EventLoadedState(this.eventList);

  @override
  List<Object?> get props => eventList;
}

class EventErrorState extends EventState {
  final String error;

  EventErrorState(this.error);

  @override
  List<Object?> get props => [error];
}