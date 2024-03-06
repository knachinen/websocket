import 'dart:async';
// import 'dart:typed_data';
import 'package:bson/bson.dart' as bson;
import 'package:web_socket_channel/web_socket_channel.dart';

class RealtimeDataService {
  void start(StreamController<Map> controller) {
    var channel = WebSocketChannel.connect(Uri.parse("ws://127.0.0.1:8000/ws"));
    channel.stream.listen((event) {
      Map data = bson.BsonCodec.deserialize(bson.BsonBinary.from(event));
      controller.add(data);
    });
  }
}
