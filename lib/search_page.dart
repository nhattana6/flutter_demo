import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_first_demo/Components/mini_card_item.dart';
import 'package:new_first_demo/LoadingComponents/mini_card_loading.dart';
import 'package:new_first_demo/Models/event.dart';
import 'package:new_first_demo/Providers/event_bloc.dart';
import 'package:new_first_demo/Providers/event_provider.dart';
import 'package:new_first_demo/Providers/event_state.dart';
import 'package:shimmer/shimmer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Event> allItems = [];
  List<Event> searchItems = [];

  void onSearchEvent(String text) {
    if (text.isEmpty) {
      setState(() {
        searchItems = allItems;
      });
    } else {
      var items = allItems
          .where((element) =>
              element.name.contains(RegExp(text, caseSensitive: false)))
          .toList();
      setState(() {
        searchItems = items;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void onCallback() {}

    return EventProvider(
      child: BlocBuilder<EventBloc, EventState>(builder: (context, state) {
        if (state.loading) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFF7C7C7C)),
                      ),
                      hintText: 'Search For....',
                      hintStyle: TextStyle(color: Color(0xFFB1B1B1)),
                      suffixIcon: Icon(
                        Icons.search,
                        size: 20.0,
                      ),
                    ),
                    readOnly: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 70,
                          height: 15,
                          color: Colors.white,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextButton.icon(
                            onPressed: () {},
                            label: const Text('A-Z'),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
            ),
          );
        }
        var eventList = List<Event>.from(state.eventList);
        if (allItems.isEmpty) {
          searchItems = eventList;
        }
        allItems = eventList;

        if (eventList.isNotEmpty) {
          var eventCount = searchItems.length == 1
              ? '${searchItems.length} Event'
              : '${searchItems.length} Events';
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                TextField(
                  onChanged: (text) => onSearchEvent(text),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Color(0xFF7C7C7C)),
                    ),
                    hintText: 'Search For....',
                    hintStyle: TextStyle(color: Color(0xFFB1B1B1)),
                    suffixIcon: Icon(
                      Icons.search,
                      size: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(eventCount,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w700)),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextButton.icon(
                          onPressed: () {},
                          label: const Text('A-Z'),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            size: 24.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                searchItems.isEmpty ? const Image(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/no_search_data.jpg'),
                ) : Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: searchItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      var item = searchItems[index];
                      return MiniCardItem(
                        event: Event(item.id, item.name, item.time,
                            item.location, item.price, item.image, false),
                        onRemoveList: onCallback,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage('assets/no_data.jpg'),
            ),
          );
        }
      }),
    );
  }
}
