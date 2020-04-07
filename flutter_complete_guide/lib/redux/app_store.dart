import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:logging/logging.dart';

import 'app_reducer.dart';
import 'app_state.dart';

Store<AppState> createStore() {
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: []
      ..addAll([
        LoggingMiddleware<dynamic>.printer(level: Level.ALL),
      ]),
  );
}