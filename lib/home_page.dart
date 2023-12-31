import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_first_demo/Components/mini_card_item.dart';
import 'package:new_first_demo/LoadingComponents/card_home_loading.dart';
import 'package:new_first_demo/LoadingComponents/mini_card_loading.dart';
import 'package:new_first_demo/Models/event.dart';
import 'package:new_first_demo/Providers/event_bloc.dart';
import 'package:new_first_demo/Providers/event_provider.dart';
import 'package:new_first_demo/Providers/event_state.dart';
import 'package:new_first_demo/add_event.dart';
import 'package:new_first_demo/router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:new_first_demo/utils/preferences.dart' as preferences;

import 'Providers/event_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // preferences.storage.remove('favoriteList');
    // TODO: implement build
    final ButtonStyle style =
    ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16),
      backgroundColor: const Color(0xFF0DCDAA),
      shape: const StadiumBorder(),
    );

    Future<void> onClickItem(int id, BuildContext context){
      return AppRouter.gotoEventDetailsScreen(
        context,
        eventId: id,
      ).then((value) => context.read<EventBloc>().add(LoadEventEvent()));
    }

    void onCallback() {
    }

    void onLikeItem(Event item) {
      item.isLike = !item.isLike;
      List<Event>? newFavoriteList = [];
      if (preferences.favoriteList != null) {
        newFavoriteList = preferences.favoriteList;
      }
      var eventItem = newFavoriteList
          ?.singleWhere((element) => element.id == item.id, orElse: () {
        return Event(0, '', '', '', 0, '', false);
      });
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

    return EventProvider(
      child: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          if(state.loading) {
            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Container(
                            width: 70,
                            height: 15,
                            color: Colors.white,
                          ),

                            const SizedBox(height: 7),
                            Container(
                              width: 100,
                              height: 25,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: ElevatedButton(
                          onPressed: (){},
                          style: style,
                          child: const Text('New Event', style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 150,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const CardHomeLoading(),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return const MiniCardLoading();
                    },
                  ),
                ],
              ),
            );
          }
          var eventList = List<Event>.from(state.eventList);
          if(eventList.isNotEmpty) {
            // get first item
            var firstItem = eventList.first;
            var eventDate = DateTime.parse(firstItem.time);
            String formattedDate = DateFormat('EEE, MMM dd · hh.mm a').format(eventDate);
            var isLike = false;

            if (preferences.favoriteList != null) {
              var newFavoriteList = preferences.favoriteList;
              var eventItem = newFavoriteList
                  ?.singleWhere((element) => element.id == firstItem.id, orElse: () {
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
                  ?.singleWhere((element) => element.id == firstItem.id, orElse: () {
                return Event(0, '', '', '', 0, '', false);
              });
              if (eventItem?.id != 0) {
                isNew = false;
              }
            }

            // get next 3 items
            var nextItems = eventList.skip(1).take(3).toList();
            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Find events in', style: TextStyle(fontSize: 12, color: Color(0xFF7C7C7C))),
                            const SizedBox(height: 7),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 20.0,
                                ),
                                Expanded(child: Text(state.location, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),))
                              ],
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AddEvent()),
                          ).then((value) => context.read<EventBloc>().add(LoadEventEvent()));
                        },
                        style: style,
                        child: const Text('New Event', style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Text('Popular in ${state.location}', style: const TextStyle(fontSize: 16),),
                  ),
                  Stack(
                      children: <Widget>[
                        InkWell(
                          onTap: () => onClickItem(1, context),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AspectRatio(
                                  aspectRatio: 100 / 35,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10), topRight: Radius.circular(10)
                                      ),
                                      image: DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          alignment: FractionalOffset.topCenter,
                                          image: NetworkImage(firstItem.image)
                                      ),
                                    ),
                                  ),
                                ),
                                Column(children:[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(formattedDate, style: const TextStyle(fontSize: 12)),
                                        const SizedBox(height: 7),
                                        Text(firstItem.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,
                                              size: 20.0,
                                            ),
                                            Text(firstItem.location, style: const TextStyle(fontSize: 12))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                icon: isLike
                                                    ? const Icon(Icons.favorite)
                                                    : const Icon(Icons.favorite_border),
                                                color: isLike
                                                    ? const Color(0xFFF01717)
                                                    : const Color(0xFF7C7C7C),
                                                onPressed: () => onLikeItem(firstItem)
                                            ),
                                            IconButton(
                                                icon: const Icon(Icons.share), color: const Color(0xFF7C7C7C), onPressed: (){}
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ]),
                              ],
                            ),
                          ),
                        ),
                        if(isNew)
                        Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: const Color(0xFF30D969),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: const Text('New', style: TextStyle(color: Colors.white, fontSize: 12),),
                            )
                        )
                      ]),
                  // Column(
                  //   children: [
                  //     MiniCardItem(event: Event(1, 'The Kooks', 'Thu, Apr 19 · 20.00 Pm', 'Razzmatazz', 100, 'assets/card_image.png', false)),
                  //     MiniCardItem(event: Event(2, 'The Numbers', 'Thu, Apr 22 · 20.00 Pm', 'Razzmatazz', 100, 'assets/card_mini_image1.png', false)),
                  //     MiniCardItem(event: Event(3, 'The Mentors', 'Thu, Apr 24 · 20.00 Pm', 'Binh Dinh', 100, 'assets/card_mini_image2.png', false)),
                  //   ],
                  // )
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: nextItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = nextItems[index];
                      return MiniCardItem(event: Event(item.id, item.name, item.time, item.location, item.price, item.image, false),
                        onRemoveList: onCallback,);
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}