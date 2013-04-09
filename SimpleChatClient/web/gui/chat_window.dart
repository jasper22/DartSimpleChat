
import 'package:web_ui/web_ui.dart';

/**
 * Class will provide chat 'window' functions
 */
class ChatWindow extends WebComponent
{
  /// Global variable (used in HTML) to notice user of connection to server
  bool ServerConnected;
  
  /**
   * Default ctor
   */
  ChatWindow()
  {
    ServerConnected = false;
  }
}