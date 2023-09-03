import 'package:flutter/material.dart';
import 'package:new_first_demo/favorite_page.dart';
import 'package:new_first_demo/home_page.dart';
import 'package:new_first_demo/past_ticket.dart';
import 'package:new_first_demo/search_page.dart';
import 'package:new_first_demo/settings_page.dart';
import 'package:new_first_demo/upcoming_ticket.dart';

class BottomBar extends StatefulWidget {
  static const routeName = '/';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  double heightAppBar = 50;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const SearchPage(),
    const TabBarView(
      children: [
        UpcomingTicket(),
        PastTicket(),
      ],
    ),
    const FavoritePage(),
    const SettingsPage(),
  ];

  Widget widgetAppBarOptions(){
    if (_selectedIndex != 2) {
      return AppBar(
        centerTitle: true,
        elevation: 0,
      );
    }
    return AppBar(
      backgroundColor: const Color(0xFF0DCDAA),
      elevation: 0,
      toolbarHeight: 140,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBar(
              indicator: const UnderlineTabIndicator(),
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              indicatorColor: Colors.white,
              unselectedLabelColor: const Color(0xFFF2F2F2).withOpacity(0.75),
              labelColor: Colors.white,
              labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              tabs: const [
                Tab(text: 'Upcoming'),
                Tab(text: 'Past Tickets'),
              ],
            ),
          ),
        ),
      ),
      title: const Text('Tickets', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      heightAppBar = index == 2 ? 140 : 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFF2F2F2);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(heightAppBar),
            child: widgetAppBarOptions(),
          ),
          body: SafeArea(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "home",
                backgroundColor: bgColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "search",
                backgroundColor: bgColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.airplane_ticket_outlined),
                label: "ticket",
                backgroundColor: bgColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: "favorite",
                backgroundColor: bgColor,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: "settings",
                backgroundColor: bgColor,
              ),
            ],
            showUnselectedLabels: false,
            showSelectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            unselectedItemColor: const Color(0xFFBDBDBD),
            selectedItemColor: const Color(0xFF333538),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}