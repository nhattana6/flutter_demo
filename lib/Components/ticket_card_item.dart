import 'package:flutter/material.dart';
import 'package:new_first_demo/Models/event.dart';
import '../router.dart';

class TicketCardItem extends StatefulWidget {
  const TicketCardItem({super.key, required this.event});
  final Event event;

  @override
  State<TicketCardItem> createState() => _TicketCardItemState();
}

class _TicketCardItemState extends State<TicketCardItem> {
  Future<void> onClickItem(int id){
    return AppRouter.gotoEventDetailsScreen(
      context,
      eventId: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClickItem(widget.event.id),
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(color: Color(0xFFF2F2F2)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Image(
                                fit: BoxFit.cover,
                                width: 20,
                                image: AssetImage('assets/ticket_icon.png'),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.event.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 7),
                                  Text(widget.event.time, style: const TextStyle(fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text('3 Ticket’s', style: const TextStyle(fontSize: 12))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                child: Image(
                  fit: BoxFit.cover,
                  width: 130,
                  height: 90,
                  image: AssetImage(widget.event.image),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
