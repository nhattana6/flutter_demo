import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardHomeLoading extends StatefulWidget {
  const CardHomeLoading({super.key});

  @override
  State<CardHomeLoading> createState() => _CardHomeLoadingState();
}

class _CardHomeLoadingState extends State<CardHomeLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10), topRight: Radius.circular(10)
                  ),
                  image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.topCenter,
                      image: AssetImage('assets/card_image.png')
                  ),
                ),
              ),
            ),
          ),
          Column(children:[
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      height: 12,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 100,
                      height: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: 200,
                      height: 12,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 19),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ],
      ),
    );
  }
}
