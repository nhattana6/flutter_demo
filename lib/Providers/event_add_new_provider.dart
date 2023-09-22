import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_first_demo/Services/EventApiProvider.dart';

import 'event_details_bloc.dart';
import 'event_details_event.dart';

class EventAddNewProvider extends StatelessWidget {
  final Widget child;

  const EventAddNewProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ApiProvider(),
      child: BlocProvider<EventDetailBloc>(
        create: (BuildContext context) => EventDetailBloc(RepositoryProvider.of<ApiProvider>(context)),
        child: child,
      ),
    );
  }
}
