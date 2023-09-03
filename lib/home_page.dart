import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_first_demo/Components/mini_card_item.dart';
import 'package:new_first_demo/Models/event.dart';
import 'package:new_first_demo/Providers/event_bloc.dart';
import 'package:new_first_demo/Providers/event_provider.dart';
import 'package:new_first_demo/Providers/event_state.dart';
import 'package:new_first_demo/add_event.dart';
import 'package:new_first_demo/router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ButtonStyle style =
    ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 16),
      backgroundColor: const Color(0xFF0DCDAA),
      shape: const StadiumBorder(),
    );

    Future<void> onClickItem(int id){
      return AppRouter.gotoEventDetailsScreen(
        context,
        eventId: id,
      );
    }

    return EventProvider(
      child: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          var eventList = List<Event>.from(state.eventList);
          if(state.loading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Loading data',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            );
          }
          var firstItem = eventList.first;
          var eventDate = DateTime.parse(firstItem.time);
          String formattedDate = DateFormat('EEE, MMM dd · hh.mm a').format(eventDate);
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Find events in', style: TextStyle(fontSize: 12, color: Color(0xFF7C7C7C))),
                        SizedBox(height: 7),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 20.0,
                            ),
                            Text('Quy Nhơn', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddEvent()),
                        );
                      },
                      style: style,
                      child: const Text('New Event', style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text('Popular in Quy Nhơn', style: TextStyle(fontSize: 16),),
                ),
                Stack(
                    children: <Widget>[
                      InkWell(
                        onTap: () => onClickItem(1),
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
                                              icon: const Icon(Icons.favorite_border), color: const Color(0xFF7C7C7C), onPressed: (){}
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
                Column(
                  children: [
                    MiniCardItem(event: Event(1, 'The Kooks', 'Thu, Apr 19 · 20.00 Pm', 'Razzmatazz', 100, 'assets/card_image.png', false)),
                    MiniCardItem(event: Event(2, 'The Numbers', 'Thu, Apr 22 · 20.00 Pm', 'Razzmatazz', 100, 'assets/card_mini_image1.png', false)),
                    MiniCardItem(event: Event(3, 'The Mentors', 'Thu, Apr 24 · 20.00 Pm', 'Binh Dinh', 100, 'assets/card_mini_image2.png', false)),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}