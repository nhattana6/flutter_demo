import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:new_first_demo/Models/event.dart';

@immutable
abstract class EventEvent extends Equatable {
  const EventEvent();
}

class LoadEventEvent extends EventEvent {
  @override
  List<Event> get props => [];
}