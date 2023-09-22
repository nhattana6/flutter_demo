import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_first_demo/LoadingComponents/event_details_loading.dart';
import 'package:new_first_demo/Models/event.dart';
import 'package:new_first_demo/Providers/event_bloc.dart';
import 'Providers/event_details_bloc.dart';
import 'Providers/event_details_event.dart';
import 'Providers/event_details_provider.dart';
import 'Providers/event_details_state.dart';
import 'package:new_first_demo/utils/preferences.dart' as preferences;
import 'Providers/event_event.dart';

class EventDetails extends StatefulWidget {
  static const routeName = '/event_details';

  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    final eventId = ModalRoute.of(context)!.settings.arguments as int;

    final ButtonStyle styleDeleteButton = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16),
      backgroundColor: const Color(0xFFE26464),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    void onLikeItem(Event item) {
      List<Event>? newFavoriteList = [];
      if (preferences.favoriteList != null) {
        newFavoriteList = preferences.favoriteList;
      }
      var eventItem = newFavoriteList
          ?.singleWhere((element) => element.id == item.id, orElse: () {
        return Event(0, '', '', '', 0, '', false);
      });

      if (eventItem?.id != 0) {
        item.isLike = false;
      } else {
        item.isLike = !item.isLike;
      }

      if (item.isLike) {
        if (eventItem?.id == 0) {
          newFavoriteList?.add(item);
        }
      } else {
        if (eventItem?.id != 0) {
          newFavoriteList?.remove(eventItem);
        }
      }

      preferences.favoriteList = newFavoriteList;
      setState(() {});
    }

    void onDeleteEvent(BuildContext context) {
      context.read<EventDetailBloc>().add(LoadDeleteEvent(eventId));
      BlocProvider.of<EventBloc>(context).add(LoadEventEvent());
    }

    void onBack(BuildContext ctx) {
      Navigator.of(ctx).pop();
      Navigator.of(context).pop();
    }

    // TODO: implement build
    return EventDetailProvider(
      id: eventId,
      child: BlocBuilder<EventDetailBloc, EventDetailsState>(
        builder: (context, state) {
          if (state.loading) {
            return const EventDetailLoading();
          } else {
            if(state.isDelete) {
              // remove from favorite list
              List<Event>? newFavoriteList = [];
              if (preferences.favoriteList != null) {
                newFavoriteList = preferences.favoriteList;
              }
              var eventItem = newFavoriteList
                  ?.singleWhere((element) => element.id == eventId, orElse: () {
                return Event(0, '', '', '', 0, '', false);
              });

              if (eventItem?.id != 0) {
                newFavoriteList?.remove(eventItem);
              }
              preferences.favoriteList = newFavoriteList;

              // remove from new event list
              List<Event>? oldEventList = [];
              if (preferences.oldEventList != null) {
                oldEventList = preferences.oldEventList;
              }
              var oldEventItem = oldEventList
                  ?.singleWhere((element) => element.id == eventId, orElse: () {
                return Event(0, '', '', '', 0, '', false);
              });

              if (oldEventItem?.id != 0) {
                oldEventList?.remove(oldEventItem);
              }
              preferences.oldEventList = oldEventList;

              Future.delayed(const Duration(seconds: 0), () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text('Delete event successfully'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => onBack(ctx),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
              });
              return const EventDetailLoading();
            } else {
              var eventDetails = state.event as Event;
              var itemDate = DateTime.parse(eventDetails.time);
              var dateFormat =
              DateFormat('EEE, MMM dd · hh.mm a').format(itemDate);
              var isLike = false;
              if (preferences.favoriteList != null) {
                var newFavoriteList = preferences.favoriteList;
                var eventItem = newFavoriteList?.singleWhere(
                        (element) => element.id == eventDetails.id, orElse: () {
                  return Event(0, '', '', '', 0, '', false);
                });
                if (eventItem?.id != 0) {
                  isLike = true;
                }
              }

              // mark item new to old
              List<Event>? oldEventList = [];
              if (preferences.oldEventList != null) {
                oldEventList = preferences.oldEventList;
              }
              var eventItem = oldEventList
                  ?.singleWhere((element) => element.id == eventId, orElse: () {
                return Event(0, '', '', '', 0, '', false);
              });
              if (eventItem?.id == 0) {
                oldEventList?.add(eventDetails);
              }
              preferences.oldEventList = oldEventList;

              return Scaffold(
                body: Column(
                  children: [
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 100 / 60,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  alignment: FractionalOffset.topCenter,
                                  image: NetworkImage(eventDetails.image)),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 5,
                            right: 5,
                            child: Row(
                              children: [
                                IconButton(
                                    icon: isLike
                                        ? const Icon(Icons.favorite)
                                        : const Icon(Icons.favorite_border),
                                    color: isLike
                                        ? const Color(0xFFF01717)
                                        : const Color(0xFFFFFFFF),
                                    onPressed: () => onLikeItem(eventDetails)),
                                IconButton(
                                    icon: const Icon(Icons.share),
                                    color: Colors.white,
                                    onPressed: () {})
                              ],
                            )),
                        Positioned(
                            left: 5,
                            bottom: 5,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(eventDetails.name,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.calendar_today_outlined,
                                      size: 20.0,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(dateFormat,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)),
                                        const Text('21:00 Pm - 23.30 Pm'),
                                        const Text('Add to calendar',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF2854C6)))
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        size: 20.0,
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(eventDetails.location,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600)),
                                          Text(eventDetails.location),
                                          const Text('View on maps',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xFF2854C6)))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Text('About',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w700)),
                            ),
                            const SizedBox(
                              height: 200,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFF2F2F2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Price',
                                    style:
                                    TextStyle(fontWeight: FontWeight.w700)),
                                Text('\$ ${eventDetails.price}')
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () => onDeleteEvent(context),
                              style: styleDeleteButton,
                              child: const Text(
                                'Delete Event',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
