
//
// Based on EventStream implementation from: http://pub.dartlang.org/packages/event_stream

part of simplechat_server;

///
/// Class implement events system
class EventStream<T>
{
  StreamController<T> _eventStreamController = new StreamController<T>.broadcast();
  
  ///
  /// Public ctor
  EventStream()
  {
  }
  
  ///
  /// Get underlying stream of events
  Stream<T> get StreamOfEvents
  {
    return _eventStreamController.stream;
  }
  
  ///
  /// Rise an event
  void Raise([T value])
  {
    _eventStreamController.add(value);
  }
}