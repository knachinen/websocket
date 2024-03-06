abstract class DataEvent {}

class DataConnectEvent extends DataEvent {}

class UpdateDataEvent extends DataEvent {
  Map data;

  UpdateDataEvent({required this.data});
}
