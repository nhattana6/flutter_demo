import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_first_demo/Models/event.dart';
import '../Providers/event_bloc.dart';
import '../Providers/event_event.dart';
import '../Providers/event_provider.dart';
import '../router.dart';
import 'package:new_first_demo/utils/preferences.dart' as preferences;

class MiniCardItem extends StatefulWidget {
  const MiniCardItem({super.key, required this.event, this.onRemoveList});

  final Event event;
  final onRemoveList;

  @override
  State<MiniCardItem> createState() => _MiniCardItemState();
}

class _MiniCardItemState extends State<MiniCardItem> {
  Future<void> onClickItem(int id) {
    return AppRouter.gotoEventDetailsScreen(
      context,
      eventId: id,
    ).then((value) => context.read<EventBloc>().add(LoadEventEvent()));
  }

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
    widget.onRemoveList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var itemDate = DateTime.parse(widget.event.time);
    var dateFormat = DateFormat('EEE, MMM dd · hh.mm a').format(itemDate);
    var isLike = false;

    if (preferences.favoriteList != null) {
      var newFavoriteList = preferences.favoriteList;
      var eventItem = newFavoriteList
          ?.singleWhere((element) => element.id == widget.event.id, orElse: () {
        return Event(0, '', '', '', 0, '', false);
      });
      if (eventItem?.id != 0) {
        isLike = true;
      }
    }

    var isNew = true;
    if(preferences.oldEventList != null) {
      var oldEventList = preferences.oldEventList;
      var eventItem = oldEventList
          ?.singleWhere((element) => element.id == widget.event.id, orElse: () {
        return Event(0, '', '', '', 0, '', false);
      });
      if (eventItem?.id != 0) {
        isNew = false;
      }
    }

    return EventProvider(
      child: InkWell(
        onTap: () => onClickItem(widget.event.id),
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: widget.event.image.contains('assets')
                      ? Image(
                          fit: BoxFit.cover,
                          width: 88,
                          height: 88,
                          image: AssetImage(widget.event.image),
                        )
                      : Image(
                          fit: BoxFit.cover,
                          width: 88,
                          height: 88,
                          image: NetworkImage(widget.event.image),
                        ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(dateFormat,
                                style: const TextStyle(fontSize: 12)),
                            const SizedBox(height: 7),
                            Text(widget.event.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 20.0,
                                ),
                                Text(widget.event.location,
                                    style: const TextStyle(fontSize: 12))
                              ],
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                                icon: isLike
                                    ? const Icon(Icons.favorite)
                                    : const Icon(Icons.favorite_border),
                                color: isLike
                                    ? const Color(0xFFF01717)
                                    : const Color(0xFF7C7C7C),
                                onPressed: () => onLikeItem(widget.event)),
                            IconButton(
                                icon: const Icon(Icons.share),
                                color: const Color(0xFF7C7C7C),
                                onPressed: () {})
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          if(isNew)
          Positioned(
              top: 10,
              left: 55,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: const Color(0xFF30D969),
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  'New',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ))
        ]),
      ),
    );
  }
}
