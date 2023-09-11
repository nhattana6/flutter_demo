import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MiniCardLoading extends StatelessWidget {
  const MiniCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: const Image(
                fit: BoxFit.cover,
                width: 88,
                height: 88,
                image: AssetImage('assets/card_image.png'),
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 50,
                        height: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 13),
                      Container(
                        width: 80,
                        height: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
