import 'dart:html';
// import 'package:web_ui/web_ui.dart';

// initial value for click-counter
int startingCount = 5;

//
// Actual websocket 
WebSocket ws = null;

/**
 * Learn about the Web UI package by visiting
 * http://www.dartlang.org/articles/dart-web-components/.
 */
void main() {
  // Enable this to use Shadow DOM in the browser.
  //useShadowDom = true;
  
  ws = new WebSocket('ws://127.0.0.1:8080/ws');
   
  ButtonElement btnSend = query('#btnSendToServer') as ButtonElement;
  btnSend.text = "Click to send to server";
  
  btnSend.onClick.listen(
      (data)
      {
        SendTestData();
      },
      onError: (ex)
                { print("Error occurred $ex"); }, 
      onDone: ()
              {
                print("Done");
              }
      );
}


void SendTestData()
{
  print("Gonna send test data");
  
  if (ws.readyState == WebSocket.OPEN)
  {
    ws.send("Hello from client");
  }
  else
  {
    print("Could not send because WebSocket is not 'Open'");
  }
}