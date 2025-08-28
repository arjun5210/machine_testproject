import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';
import 'package:tisserproject/model/data_model.dart';

part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  AddBloc() : super(AddInitial()) {
    on<AddEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<addingevent>((event, emit) async {
      emit(addedloading());
      try {
        await FirebaseFirestore.instance.collection('taskdetails').add({
          'id': event.task.id,
          'title': event.task.title,
          'desc': event.task.desc,
          'status': event.task.status,
          'date': event.task.date,
        });
        emit(addedsucess());
      } catch (e) {
        emit(addederror(error: e.toString()));
      }
    });
    on<completeevent>((event, emit) async {
      emit(addedloading());
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('taskdetails')
            .where('status', isEqualTo: 'Completed')
            .get();
        final completedTasks = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return datadetails(
            id: data['id'],
            title: data['title'],
            desc: data['desc'],
            status: data['status'],
            date: data['date'],
          );
        }).toList();
        emit(completedataloaded(completevalue: completedTasks));
      } catch (e) {
        emit(addederror(error: e.toString()));
      }
    });
    on<pendingevent>((event, emit) async {
      emit(addedloading());
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('taskdetails')
            .where('status', isEqualTo: 'Pending')
            .get();
        final completedTasks = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return datadetails(
            id: data['id'],
            title: data['title'],
            desc: data['desc'],
            status: data['status'],
            date: data['date'],
          );
        }).toList();
        emit(completedataloaded(completevalue: completedTasks));
      } catch (e) {
        emit(addederror(error: e.toString()));
      }
    });
    on<detailcompletedevent>((event, emit) async {
      emit(addedloading());
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('taskdetails')
            .where('status', isEqualTo: 'Completed')
            .get();

        final matchedTasks = snapshot.docs
            .where((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return data['title'] == event.title || data['id'] == event.id;
            })
            .map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return datadetails(
                id: data['id'],
                title: data['title'],
                desc: data['desc'],
                status: data['status'],
                date: data['date'],
              );
            })
            .toList();

        emit(detailcompletedataloaded(completevalue: matchedTasks));
      } catch (e) {
        emit(addederror(error: e.toString()));
      }
    });
    on<detailpendingevent>((event, emit) async {
      emit(addedloading());
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('taskdetails')
            .where('status', isEqualTo: 'Pending')
            .get();

        final matchedTasks = snapshot.docs
            .where((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return data['title'] == event.title || data['id'] == event.id;
            })
            .map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              return datadetails(
                id: data['id'],
                title: data['title'],
                desc: data['desc'],
                status: data['status'],
                date: data['date'],
              );
            })
            .toList();

        emit(detailcompletedataloaded(completevalue: matchedTasks));
      } catch (e) {
        emit(addederror(error: e.toString()));
      }
    });
    on<updateevent>((event, emit) async {
      emit(updateloading());
      try {
        // find the document using the task id
        var snapshot = await FirebaseFirestore.instance
            .collection('taskdetails')
            .where('id', isEqualTo: event.id) // search by id
            .limit(1)
            .get();

        if (snapshot.docs.isNotEmpty) {
          // update the first matching document
          await FirebaseFirestore.instance
              .collection('taskdetails')
              .doc(snapshot.docs.first.id)
              .update({
                'title': event.title,
                'desc': event.desc,
                'status': event.status,
                'date': event.date,
              });
          emit(updatesucess());
        } else {
          emit(updateerror(error: "Task not found"));
        }
      } catch (e) {
        emit(updateerror(error: e.toString()));
      }
    });

    on<FetchProjectCount>((event, emit) async {
      emit(ProjectCountLoading());
      try {
        final completedSnapshot = await FirebaseFirestore.instance
            .collection('taskdetails')
            .where('status', isEqualTo: 'Completed')
            .get();

        final pendingSnapshot = await FirebaseFirestore.instance
            .collection('taskdetails')
            .where('status', isEqualTo: 'Pending')
            .get();

        emit(
          ProjectCountLoaded(
            completedCount: completedSnapshot.docs.length,
            pendingCount: pendingSnapshot.docs.length,
          ),
        );
      } catch (e) {
        emit(ProjectCountError(error: e.toString()));
      }
    });
  }
}
