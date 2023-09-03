import 'package:flutter/material.dart';
import 'package:new_first_demo/add_event.dart';
import 'package:new_first_demo/bottom_bar.dart';
import 'package:new_first_demo/event_details.dart';

class AppRouter {
  const AppRouter();

  static Map<String, Widget Function(BuildContext)> routes = {
    BottomBar.routeName: (_) => const BottomBar(),
    EventDetails.routeName: (_) => EventDetails(),
    AddEvent.routeName: (_) => const AddEvent(),
  };

  static Future<void> gotoEventDetailsScreen(
    BuildContext context, {
    required int eventId,
  }) async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => EventDetails(),
      settings: RouteSettings(arguments: eventId),
    ));
  }
}
