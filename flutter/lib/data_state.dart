import 'package:websocket/data.dart';

abstract class DataState {}

class DataInitialState extends DataState {}

class DataPresentState extends DataState {
// RealtimeDataModel data;
  RealtimeDataModel data;
  DataPresentState({required this.data});
}

class DataErrorState extends DataState {}
