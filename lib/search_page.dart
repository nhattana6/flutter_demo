import 'package:flutter/material.dart';
import 'package:new_first_demo/Components/mini_card_item.dart';
import 'package:new_first_demo/Models/event.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 1, color: Color(0xFF7C7C7C)),
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
                const Text('123 Events', style: TextStyle(
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
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return MiniCardItem(event: Event(index, 'The Kooks', 'Thu, Apr 19 · 20.00 Pm', 'Razzmatazz', 100, 'assets/card_image.png', false));
              },
            ),
          ),
        ],
      ),
    );
  }
}
