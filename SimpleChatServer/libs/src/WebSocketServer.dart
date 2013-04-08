
part of simplechat_server;

/**
 *  Server implmenetation based on web sockets
 */
class WebSocketServer extends WebServerBase
{
  HttpServer _mainServerInstance = null;
  
  const String WEBSOCKET_SERVER_URI = "/ws";
  
  LocalLogger _localLogger;
  
  /**
   * Internal stream that will receive 'raw' HttpRequest messages
   * and convert them via [WebSocketTransformer] to web-socket messages
   */
  StreamController _rawMessagesController = new StreamController();
    
  /**
   *  Default ctor
   *      [address] If not provided then default address is: 127.0.0.1
   *      [port]  If not provided default port is: 8080
   *      [logger] Will log messages if provided
   */
  WebSocketServer({String address:"127.0.0.1", int port:8080, LocalLogger logger:null}) : super(address, port)
  {
    _localLogger = logger;
    
    /// Upgrade HttpRequest object to WebSocket object
    _rawMessagesController.stream
            .transform(new WebSocketTransformer())
            .listen( (webSocket) 
                      { 
                        webSocket.listen(
                                          (data) { _handleWebSocketData(data); }, 
                                          onError: (exp) { _handleWebSocketError(exp); }, 
                                          onDone: () { _handleWebSocketDone(); }
                                        );
                         
                       }
                    );
    
    if (_localLogger != null)
    {
      _localLogger.logger.info("Starting server");
    }
    
     Future<HttpServer> tmpServer = HttpServer.bind(address, port)
        .then( 
            (HttpServer createdServer) 
            {
              _mainServerInstance = createdServer;

              _mainServerInstance.listen(
                  (HttpRequest request)
                  {
                    if (request.uri.path == WEBSOCKET_SERVER_URI)
                    {
                      _rawMessagesController.add(request);
                    }
                    else
                    {
                      _onNotificationEvent.Raise("WebSocket received packet not for it");
                    }
                  }, 
                  onError: (error) { _onErrorEvent.Raise(new ErrorData("Server error!", innerException:error)); }, 
                   onDone: ()      { print("Server is done listening");                          });

              _onNotificationEvent.Raise("WebSocket server loaded at address: $address and port: $port");              
              super._IsRunning = true;                
            }
        ,
        onError: (AsyncError e)
                  {
                    _onErrorEvent.Raise(new ErrorData("Server could not be binded!", innerException:e));
                  }
        );
  }
 
  /**
   *  Stop and close web server
   */
  void Close()
  {
    super.Close();
    
    if (_mainServerInstance != null)
    {
      _mainServerInstance.close();
      
      _onNotificationEvent.Raise("Server instance closed for server: $_serverAddress:$_serverPort");
    }
  }

  /**
   *  Function will handle all incoming WebSocket messages
   */
  void _handleWebSocketData(String jsonMessageRaw)
  {
    var parse1 = JSON.parse(jsonMessageRaw);
    var jsonRawMap = JSON.parse(parse1);
    
    SimpleMessage msg = new SimpleMessage.fromJson(jsonRawMap);
    
    super.MessagesStream.add(msg);
  }
  
  /**
   * Function will handle all WebSocket errors
   */
  void _handleWebSocketError(Exception exp)
  {
    print ("Error occured in WebSocket: $exp");
    throw exp;
  }
  
  /**
   * Function wil handle WebSocket 'done' message
   */
  void _handleWebSocketDone()
  {
    print("WebSocket is done !");
  }
  
}