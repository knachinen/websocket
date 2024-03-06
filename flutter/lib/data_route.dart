import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket/data_bloc.dart';
import 'package:websocket/data_event.dart';
import 'package:websocket/data_state.dart';
import 'package:websocket/websocket_service.dart';

class DataRouteScreen extends StatefulWidget {
  const DataRouteScreen({super.key});

  @override
  State<DataRouteScreen> createState() => _DataRouteScreenState();
}

class _DataRouteScreenState extends State<DataRouteScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DataBloc>(
      create: (_) =>
          DataBloc(service: RealtimeDataService())..add(DataConnectEvent()),
      child: BlocBuilder<DataBloc, DataState>(builder: (context, state) {
        if (state is DataPresentState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Realtime Data Demo"),
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                state.data.number,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Realtime Data Demo"),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              "Connecting",
              style: TextStyle(fontSize: 24),
            ),
          ),
        );
      }),
    );
  }
}
