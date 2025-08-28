part of 'add_bloc.dart';

@immutable
sealed class AddState {}

final class AddInitial extends AddState {}

class addedsucess extends AddState {}

class addedloading extends AddState {}

class addederror extends AddState {
  String error;
  addederror({required this.error});
}

class completedataloaded extends AddState {
  List<datadetails> completevalue = [];
  completedataloaded({required this.completevalue});
}

class detailcompletedataloaded extends AddState {
  List<datadetails> completevalue = [];
  detailcompletedataloaded({required this.completevalue});
}

class updateloading extends AddState {}

class updateerror extends AddState {
  String error;
  updateerror({required this.error});
}

class updatesucess extends AddState {}

class ProjectCountLoading extends AddState {}

class ProjectCountLoaded extends AddState {
  final int completedCount;
  final int pendingCount;

  ProjectCountLoaded({
    required this.completedCount,
    required this.pendingCount,
  });
}

class ProjectCountError extends AddState {
  final String error;
  ProjectCountError({required this.error});
}
