import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_first_demo/Providers/event_bloc.dart';
import 'package:new_first_demo/Providers/event_event.dart';
import 'package:new_first_demo/Services/EventApiProvider.dart';

class EventProvider extends StatelessWidget {
  final Widget child;

  const EventProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ApiProvider(),
      child: BlocProvider<EventBloc>(
        create: (BuildContext context) => EventBloc(RepositoryProvider.of<ApiProvider>(context))..add(LoadEventEvent()),
        child: child,
      ),
    );
  }
}
