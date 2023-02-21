import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import '../../../structural/bridge/bridge/bridge_example.dart';
import '../log_bloc.dart';
import '../log_message.dart';
import '../logger_base.dart';
import '../loggers/debug_logger.dart';
import '../loggers/error_logger.dart';
import '../loggers/info_logger.dart';
import 'log_messages_column.dart';

class ChainOfResponsibilityExample extends StatefulWidget {
  const ChainOfResponsibilityExample({super.key});

  @override
  State<StatefulWidget> createState() =>
      _ChainOfResponsibilityExampleState();
}

class _ChainOfResponsibilityExampleState
    extends State<ChainOfResponsibilityExample> {
  final LogBloc logBloc = LogBloc();

  late final LoggerBase logger;

  @override
  void initState() {
    super.initState();

    logger = DebugLogger(
      logBloc,
      nextLogger: InfoLogger(
        logBloc,
        nextLogger: ErrorLogger(logBloc),
      ),
    );
  }

  @override
  void dispose() {
    logBloc.dispose();
    super.dispose();
  }

  String get randomLog => faker.lorem.sentence();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            children: <Widget>[
              PlatformButton(
                materialColor: Colors.black,
                materialTextColor: Colors.white,
                onPressed: () => logger.logDebug(randomLog),
                text: 'Log debug',
              ),
              PlatformButton(
                materialColor: Colors.black,
                materialTextColor: Colors.white,
                onPressed: () => logger.logInfo(randomLog),
                text: 'Log info',
              ),
              PlatformButton(
                materialColor: Colors.black,
                materialTextColor: Colors.white,
                onPressed: () => logger.logError(randomLog),
                text: 'Log error',
              ),
              const Divider(),
              Row(
                children: <Widget>[
                  Expanded(
                    child: StreamBuilder<List<LogMessage>>(
                      initialData: const [],
                      stream: logBloc.outLogStream,
                      builder: (context, snapshot) =>
                          LogMessagesColumn(logMessages: snapshot.data!),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
