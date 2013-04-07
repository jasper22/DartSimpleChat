
import '../libs/Server.dart';

void main() 
{
  WebServerBase serverBase = new WebSocketServer();
  
  //
  // Events
  serverBase.onNotification.listen(
      (message) { print("Server message: $message"); 
      });

  
  serverBase.onError.listen(
      (errorData) {
        print("Error occurred in web server. Error is: $errorData");
      });
  
  if(serverBase.IsRunning)
  {
    print("Server running now");
  }
  
  serverBase.MessagesStream.listen((messageReceived) {
    print("Message received from user: " + messageReceived.Text);
    
  });
  
  serverBase.Close();
  
  while(serverBase.IsRunning)
  {
    print("Still running....");
  }
  
  print("Server is not running...");
  
  print("Application close");
}
