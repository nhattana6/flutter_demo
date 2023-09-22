import 'package:flutter/material.dart';
import 'package:new_first_demo/Components/mini_card_item.dart';
import 'package:new_first_demo/Models/event.dart';
import 'package:new_first_demo/utils/preferences.dart' as preferences;

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  var emptyPage = false;


  void onRemoveList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var favoriteList = preferences.favoriteList;
    var countItem = favoriteList != null ? favoriteList?.length : 0;
    if (!emptyPage) {
      return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Favorites',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFF0DCDAA),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        countItem.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: countItem,
                    itemBuilder: (BuildContext context, int index) {
                      var item = favoriteList?[index];
                      return MiniCardItem(event: Event(item!.id, item.name, item.time, item.location, item.price, item.image, true),
                          onRemoveList: onRemoveList);
                    },
                  ),
                ),
              ],
            ),
          );
    } else {
      return const Padding(
          padding: EdgeInsets.only(left: 100, right: 100),
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite,
                    size: 100,
                    color: Color(0xFFF2F2F2),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'No favourites yes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'Make sure you have added event’s in this section',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
        );
    }
  }
}
