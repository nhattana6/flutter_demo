import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_first_demo/Services/EventApiProvider.dart';

import 'event_bloc.dart';
import 'event_details_bloc.dart';
import 'event_details_event.dart';

class EventDetailProvider extends StatelessWidget {
  final Widget child;
  final int id;

  const EventDetailProvider({super.key, required this.child, required this.id});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ApiProvider(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<EventDetailBloc>(
            create: (BuildContext context) =>
                EventDetailBloc(RepositoryProvider.of<ApiProvider>(context))
                  ..add(LoadEventDetailsEvent(id)),
          ),
          BlocProvider<EventBloc>(
            create: (BuildContext context) =>
                EventBloc(RepositoryProvider.of<ApiProvider>(context)),
          )
        ],
        child: child,
      ),
    );
  }
}
