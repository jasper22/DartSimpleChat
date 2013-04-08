
part of simplechat_server;

///
/// Server implmenetation based on web sockets
class WebSocketServer extends WebServerBase
{
  HttpServer _mainServerInstance = null;
  const String WEBSOCKET_SERVER_URI = "/ws";
  
  
  ///
  /// Internal stream that will receive 'raw' HttpRequest messages 
  /// and convert them via [WebSocketTransformer] to web-socket messages
  StreamController _rawMessagesController = new StreamController();
    
  ///
  /// ctor
  WebSocketServer({String address:"127.0.0.1", int port:8080}) : super(address, port)
  {
    //
    // Upgrade HttpRequest object to WebSocket object
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
    
    logger.info("Starting server");
    
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
                  onError: (error) { _onErrorEvent.Raise(new ErrorData("Server error!", error)); }, 
                   onDone: ()      { print("Server is done listening");                          });

              _onNotificationEvent.Raise("WebSocket server loaded at address: $address and port: $port");              
              super._IsRunning = true;                
            }
        ,
        onError: (AsyncError e)
                  {
                    _onErrorEvent.Raise(new ErrorData("Server could not be binded!", e));
                  }
        );
  }
 
  ///
  /// Stop and close web server
  void Close()
  {
    super.Close();
    
    if (_mainServerInstance != null)
    {
      _mainServerInstance.close();
      
      _onNotificationEvent.Rise("Server instance closed for server: $_serverAddress:$_serverPort");
    }
  }

  ///
  /// Function will handle all incoming WebSocket messages
  void _handleWebSocketData(message)
  {
    super.MessagesStream.add(new SimpleMessage(text:message));
  }
  
  
  void _handleWebSocketError(Exception exp)
  {
    print ("Error occured in WebSocket: $exp");
    throw exp;
  }
  
  void _handleWebSocketDone()
  {
    print("WebSocket is done !");
  }
  
}