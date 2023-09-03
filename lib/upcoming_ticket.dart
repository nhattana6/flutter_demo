import 'package:flutter/material.dart';
import 'package:new_first_demo/Components/ticket_card_item.dart';
import 'package:new_first_demo/Models/event.dart';

class UpcomingTicket extends StatefulWidget {
  const UpcomingTicket({super.key});

  @override
  State<UpcomingTicket> createState() => _UpcomingTicketState();
}

class _UpcomingTicketState extends State<UpcomingTicket> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return TicketCardItem(event: Event(index, 'The Kooks','Thu, Apr 19 · 20.00 Pm','Razzmatazz', 100, 'assets/card_image.png', false),);
        },
      ),
    );
  }
}
