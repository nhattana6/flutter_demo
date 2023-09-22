import 'package:get_storage/get_storage.dart';
import 'package:new_first_demo/Models/event.dart';

final GetStorage storage = GetStorage('Preferences');

void _set(String key, dynamic value) => storage.write(key, value);

T? _get<T>(String key) => storage.read(key);

set username(String? name) => _set('userName', name);

String? get username => _get<String>('userName');

set favoriteList(List? list) => _set('favoriteList', list?.map((e) => e.toJson()).toList());

List<Event>? get favoriteList => _get<List>('favoriteList') != null ? List<Event>.from(_get<List>('favoriteList')!.map<Event>((e) => Event.fromJson(e))) : [];

set oldEventList(List? list) => _set('oldEventList', list?.map((e) => e.toJson()).toList());

List<Event>? get oldEventList => _get<List>('oldEventList') != null ? List<Event>.from(_get<List>('oldEventList')!.map<Event>((e) => Event.fromJson(e))) : [];