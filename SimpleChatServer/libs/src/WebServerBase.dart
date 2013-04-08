
part of simplechat_server;

///
/// Base web server implementation that all
/// variations of 'web server' must support
abstract class WebServerBase
{
  ///
  /// Global logger
  Logger _logger = null;
  
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
  /// Get stream controller of messages from users
  StreamController<SimpleMessage> get MessagesStream
  {
    return _messagesStream;
  }
    
  ///
  /// Get the global logger
  Logger get logger
  {
    if (_logger == null)
    {
      _logger = _createLogger();
    }
    
    return _logger;
  }
  
  ///
  /// Function will set-up the [log4dart] logger
  /// Return fully configured [Logger]
  Logger _createLogger()
  {
    DateTime _localDate = new DateTime.now(); 
    
    String currentDir = new Directory.current().path;
    
    Directory logDir = new Directory(currentDir + "/" + "log");
    
    logDir.exists().then( 
        (bool ifExist) {
          if (ifExist == false)
          {
            logDir.create(recursive:false).then(
                (Directory createdDir) 
                { 
                  logDir = createdDir;
                  print("Log directory created at: ${logDir.path}");
                }, 
                onError: (ex)
                          { 
                            print("!! WARNING: Could not create directory for logging !!  $ex");
                            throw new Exception(ex.error);
                           });
          }
          else
          {
            // Directory exist
          }
        }
    , onError: (ex) {});
    
    LoggerFactory.config[".*"].appenders = [new ConsoleAppender(), 
                                            new FileAppender(logDir.path + "/"  + "SimpleChatServer" + 
                                                              "-" + _localDate.day.toString() + 
                                                              "-" + _localDate.month.toString() + 
                                                              "-" + _localDate.year.toString() + 
                                                              "_" + _localDate.hour.toString() + 
                                                              "-" + _localDate.minute.toString() +
                                                              "-" + _localDate.second.toString() +
                                                              ".log")
                                            ];
    
    return LoggerFactory.getLogger("SimpleChatServer_WebSocketServer");
  }
}