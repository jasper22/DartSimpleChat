
part of simplechat_server;

///
/// Server implmenetation based on web sockets
class WebSocketServer extends WebServerBase
{
  HttpServer _mainServerInstance = null;
  
  ///
  /// ctor
  WebSocketServer({String address:"127.0.0.1", int port:8080}) : super(address, port)
  {
     Future<HttpServer> tmpServer = HttpServer.bind(address, port)
        .then( (HttpServer createdServer) {
          _mainServerInstance = createdServer;
          
          _onNotificationEvent.Rise("WebSocket server loaded at address: $address and port: $port");
          
          for(int iCounter =0; iCounter < 100; iCounter++)
            _onNotificationEvent.Rise("Running $iCounter");
          
        },
        onError: (AsyncError e){
          _onErrorEvent.Rise(e);
        });
  }
 
  ///
  /// Stop and close web server
  void Close()
  {
    if (_mainServerInstance != null)
    {
      _mainServerInstance.close();
      
      _onNotificationEvent.Rise("Server instance closed for server: $_serverAddress:$_serverPort");
    }
    
    super.Close();
  }
}