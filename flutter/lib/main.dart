import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bson/bson.dart' as bson;
import 'package:web_socket_channel/web_socket_channel.dart';

class RealtimeDataService {
  StreamController<Map> start() {
    var channel = WebSocketChannel.connect(Uri.parse("ws://127.0.0.1:8000/ws"));
    var controller = StreamController<Map>();

    channel.stream.listen((event) {
      Map data = bson.BsonCodec.deserialize(bson.BsonBinary.from(event));
      controller.add(data);
    });

    return controller;
  }
}

class RealtimeDataModel {
  String number;
  RealtimeDataModel({required this.number});
}

class DataRouteScreen extends StatefulWidget {
  const DataRouteScreen({super.key});

  @override
  State<DataRouteScreen> createState() => _DataRouteScreenState();
}

class _DataRouteScreenState extends State<DataRouteScreen> {
  late StreamController<Map> _streamController;

  @override
  void initState() {
    super.initState();
    _streamController = RealtimeDataService().start();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Realtime Data Demo")),
      body: StreamBuilder<Map>(
        stream: _streamController.stream,
        builder: (context, snapshot) {
          final number = snapshot.data?["number"] ?? "";
          return Container(
            alignment: Alignment.center,
            child: Text(
              number.isNotEmpty ? number : "Connecting",
              style: const TextStyle(fontSize: 32, color: Colors.blueGrey),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Realtime Demo',
      home: DataRouteScreen(),
    );
  }
}
