import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:new_first_demo/Components/ticket_card_item.dart';
import 'package:new_first_demo/Models/event.dart';

class PastTicket extends StatefulWidget {
  const PastTicket({super.key});

  @override
  State<PastTicket> createState() => _PastTicketState();
}

class _PastTicketState extends State<PastTicket> {
  var groupByDate = groupBy(
    [
      Event(1, 'The Kooks', 'Thu, Apr 19 · 20.00 Pm', 'Razzmatazz', 100,
          'assets/card_image.png', false, '2021'),
      Event(2, 'The Kooks', 'Thu, Apr 19 · 20.00 Pm', 'Razzmatazz', 100,
          'assets/card_image.png', false, '2022'),
      Event(3, 'The Kooks', 'Thu, Apr 19 · 20.00 Pm', 'Razzmatazz', 100,
          'assets/card_image.png', false, '2021'),
      Event(4, 'The Kooks', 'Thu, Apr 19 · 20.00 Pm', 'Razzmatazz', 100,
          'assets/card_image.png', false, '2021'),
      Event(5, 'The Kooks', 'Thu, Apr 19 · 20.00 Pm', 'Razzmatazz', 100,
          'assets/card_image.png', false, '2023'),
      Event(6, 'The Kooks', 'Thu, Apr 19 · 20.00 Pm', 'Razzmatazz', 100,
          'assets/card_image.png', false, '2025'),
      Event(7, 'The Kooks', 'Thu, Apr 19 · 20.00 Pm', 'Razzmatazz', 100,
          'assets/card_image.png', false, '2021'),
      Event(8, 'The Kooks', 'Thu, Apr 19 · 20.00 Pm', 'Razzmatazz', 100,
          'assets/card_image.png', false, '2022'),
    ],
    (p) => p.year,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: groupByDate.length,
          itemBuilder: (_, index) {
            String? year = groupByDate.keys.elementAt(index);
            List itemsInCategory = groupByDate[year]!;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Text(year!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF7C7C7C)),),
                  ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: itemsInCategory.length,
                    itemBuilder: (_, index) => TicketCardItem(
                      event: itemsInCategory[index],
                    ),
                  ),
                  const SizedBox(height: 20,),
                ]);
          }),
    );
  }
}
