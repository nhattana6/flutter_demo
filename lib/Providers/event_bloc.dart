import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Services/EventApiProvider.dart';
import 'event_event.dart';
import 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final ApiProvider _eventRepository;

  EventBloc(this._eventRepository) : super(EventLoadingState()) {
    on<LoadEventEvent>((event, emit) async {
      emit(EventLoadingState());
      try {
        String? locationName = '';
        if(await Permission.location.serviceStatus.isEnabled) {
          var status = await Permission.location.status;
          if(status.isGranted) {
            var location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
            List<Placemark> placeMarks = await placemarkFromCoordinates(
                location.latitude,
                location.longitude
            );
            Placemark place = placeMarks[0];
            locationName = place.locality;
          } else if(status.isDenied) {
              Map<Permission, PermissionStatus> statusRequest = await [
                Permission.location
              ].request();
              if(statusRequest.entries.first.value.isPermanentlyDenied) {
                openAppSettings();
              } else {
                var location = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                List<Placemark> placeMarks = await placemarkFromCoordinates(
                    location.latitude,
                    location.longitude
                );
                Placemark place = placeMarks[0];
                locationName = place.locality;
              }
          }
        }
        print(locationName);
        final joke = await _eventRepository.fetchEventList();
        emit(EventLoadedState(joke, locationName));
      } catch (e) {
        emit(EventErrorState(e.toString()));
      }
    });
  }
}