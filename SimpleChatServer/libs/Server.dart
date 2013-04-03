
library simplechat_server;

import 'dart:io';
import 'dart:async';

part 'src/WebSocketServer.dart';

///
/// Base web server implementation that all
/// variations of 'web server' must support
abstract class WebServerBase
{
  String _serverAddress;
  int _serverPort;
  
  ///
  /// Default ctor
  /// User must provide [address] and [port] to bind to
  /// Deafult [address] is 127.0.0.1
  /// Default [port] is 8080
  WebServerBase([String address = '127.0.0.1', int port = 8080])
  {
    _serverAddress = address;
    _serverPort = port;
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
}