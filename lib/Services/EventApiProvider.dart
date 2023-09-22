import 'package:dio/dio.dart';
import 'package:new_first_demo/Models/event.dart';

import '../utils/constant.dart';

class ApiProvider {
  final Dio _dio = Dio(Apis.baseDioConfigWithoutToken);

  Future<List<Event>> fetchEventList() async {
    try {
      Response response = await _dio.get("/events");
      var list = response.data;
      var dataList = List<Event>.from(list.map((item) => Event.fromJson(item as Map<String, dynamic>)).toList());
      return dataList;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<Event> fetchEventDetails(int id) async {
    try {
      Response response = await _dio.get('/events/$id');
      var data = response.data;
      var eventDetails = Event.fromJson(data as Map<String, dynamic>);
      return eventDetails;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<Event> createNewEvent(Event eventItem) async {
    try {
      Response response = await _dio.post('/events', data: eventItem.toJson());
      var data = response.data;
      var eventDetails = Event(data['id'], eventItem.name, eventItem.time, eventItem.location, eventItem.price, eventItem.image, false);
      return eventDetails;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<Event> deleteEvent(int id) async {
    try {
      Response _ = await _dio.delete('/events/$id');
      return Event(0,'','','',0,'',false);
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}