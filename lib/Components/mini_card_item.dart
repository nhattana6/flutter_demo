import 'package:flutter/material.dart';
import 'package:new_first_demo/Models/event.dart';
import '../router.dart';

class MiniCardItem extends StatefulWidget {
  const MiniCardItem({super.key, required this.event});

  final Event event;

  @override
  State<MiniCardItem> createState() => _MiniCardItemState();
}

class _MiniCardItemState extends State<MiniCardItem> {
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
      child: Stack(
          children:[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: widget.event.image.contains('assets') ? Image(
                      fit: BoxFit.cover,
                      width: 88,
                      height: 88,
                      image: AssetImage(widget.event.image),
                    ) : Image(
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
                              Text(widget.event.time, style: const TextStyle(fontSize: 12)),
                              const SizedBox(height: 7),
                              Text(widget.event.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 20.0,
                                  ),
                                  Text(widget.event.location, style: const TextStyle(fontSize: 12))
                                ],
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                  icon: widget.event.isLike ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
                                  color: widget.event.isLike ? const Color(0xFFF01717) : const Color(0xFF7C7C7C), onPressed: (){}
                              ),
                              IconButton(
                                  icon: const Icon(Icons.share), color: const Color(0xFF7C7C7C), onPressed: (){}
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                top: 10,
                left: 55,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: const Color(0xFF30D969),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: const Text('New', style: TextStyle(color: Colors.white, fontSize: 12),),
                )
            )
          ]
      ),
    );
  }
}
