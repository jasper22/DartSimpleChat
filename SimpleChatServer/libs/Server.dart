
library simplechat_server;

import 'dart:io';
import 'dart:async';

part 'src/ErrorData.dart';
part 'src/WebSocketServer.dart';
part 'src/EventStream.dart';
part 'src/SimpleMessage.dart';

///
/// Base web server implementation that all
/// variations of 'web server' must support
abstract class WebServerBase
{
  String _serverAddress;
  int _serverPort;
  
  //
  // True if server running, otherwise 'false'
  bool _isRunning = false;

  //
  // Events
  EventStream<ErrorData> _onErrorEvent;
  EventStream<String> _onNotificationEvent;

  //
  // Actuall 'messages' stream
  StreamController<SimpleMessage> _messagesStream = new StreamController<SimpleMessage>();
  
  ///
  /// Default ctor
  /// User must provide [address] and [port] to bind to
  /// Deafult [address] is 127.0.0.1
  /// Default [port] is 8080
  WebServerBase([String address = '127.0.0.1', int port = 8080])
  {
    _serverAddress = address;
    _serverPort = port;
    
    _onErrorEvent = new EventStream<ErrorData>();
    _onNotificationEvent = new EventStream<String>();
  }
  
  ///
  /// Create 'web socket' based server
  factory WebServerBase.webSocketServer([String address = '127.0.0.1', int port = 8080])
  {
    return new WebSocketServer(address, port);
  }
  
  ///
  /// Get server address to where server binded
  String get ServerAddress 
  {
    return _serverAddress;
  }
  
  ///
  /// Get server port number
  int get ServerPort
  {
    return _serverPort;
  }
  
  ///
  /// Event will be rised when any error occurred
  Stream get onError
  {
    return _onErrorEvent.StreamOfEvents;
  }
  
  ///
  /// Event will be rised for 'notifications'
  Stream get onNotification
  {
    return _onNotificationEvent.StreamOfEvents;
  }
  
  ///
  /// 'True' if server running, otherwise 'false'
  bool get IsRunning
  {
    return _isRunning;
  }
  
  ///
  /// Private set for server 'running' status
  void set _IsRunning(bool value)
  {
    _isRunning = value;
  }
  
  ///
  /// Stop the server
  void Close()
  {
    _isRunning = false;
  }
  
  ///
  /// Get stream of messages from users
  Stream get MessagesStream
  {
    return _messagesStream.stream;
  }
}