import 'dart:async';

class TaskSequencer {
  static Future<void> _lastTask = Future.value();

  static Future<void> add(Future<void> Function() task) {
    _lastTask = _lastTask.then((_) => task());
    return _lastTask;
  }
}
