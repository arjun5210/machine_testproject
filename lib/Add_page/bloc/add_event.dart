part of 'add_bloc.dart';

@immutable
sealed class AddEvent {}

class addingevent extends AddEvent {
  final datadetails task;

  addingevent({required this.task});
}

class completeevent extends AddEvent {}

class pendingevent extends AddEvent {}

class detailcompletedevent extends AddEvent {
  String id;
  String title;

  detailcompletedevent({required this.id, required this.title});
}

class detailpendingevent extends AddEvent {
  String id;
  String title;

  detailpendingevent({required this.id, required this.title});
}

class updateevent extends AddEvent {
  String id;
  String title;
  String desc;
  String status;
  String date;

  updateevent({
    required this.id,
    required this.date,
    required this.desc,
    required this.status,
    required this.title,
  });
}

class FetchProjectCount extends AddEvent {}
