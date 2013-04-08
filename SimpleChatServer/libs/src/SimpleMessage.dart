
part of simplechat_server;

///
/// Object represent a single 'message'
class SimpleMessage
{
  String _text;
  
  ///
  /// ctor
  SimpleMessage({String text:null})
  {
    this._text = text;
  }
  
  ///
  /// Get the text from message
  String get Text
  {
    return _text;
  }
}


