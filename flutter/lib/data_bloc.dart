import 'dart:async';

import 'package:bloc/bloc.dart';
// import 'package:logger/logger.dart';
import 'package:websocket/data_event.dart';
import 'package:websocket/data_state.dart';
import 'package:websocket/data.dart';

import './websocket_service.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  RealtimeDataService service;
  late StreamController<Map> _streamController;

  DataBloc({required this.service}) : super(DataInitialState()) {
    on<DataConnectEvent>(_start);
    on<UpdateDataEvent>(_update);

    _streamController =
        StreamController(); // Here we initialize the stream controller
  }

  void _start(event, emit) {
    service.start(
        _streamController); // This is the service that we created previously
    _streamController.stream.listen((data) async {
      add(UpdateDataEvent(
          data:
              data)); // Everytime a change occurs in the stream, we add a new state
    });
  }

  void _update(event, emit) {
    emit(DataPresentState(data: RealtimeDataModel.fromMap(event.data)));
  }
}
