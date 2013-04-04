
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
    _rawMessagesController.stream
            .transform(new WebSocketTransformer())
            .listen( (message) { _handleMessage(message); });
    
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

  void _handleMessage(message)
  {
    print("Message is: $message");
    super.MessagesStream.add(new SimpleMessage($message));
  }
}