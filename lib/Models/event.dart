import 'dart:math';
class Event {
  int id;
  String name;
  String time;
  String location;
  int price;
  String image;
  bool isLike;
  String? year;
  //constructor:
  Event(
    this.id,
    this.name,
    this.time,
    this.location,
    this.price,
    this.image,
    this.isLike,
    [this.year]
  );

  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        time = json['time'],
        location = json['location'],
        price = json['price'],
        image = json['image'],
        isLike = false;

  Map<String, dynamic> toJson() => {
    'name': name,
    'time': time,
    'location': location,
    'price': price,
    'image': image
  };
}

