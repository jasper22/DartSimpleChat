
part of simplechat_server;


///
/// Class will hold various error state values
class ErrorData
{
  String _message;
  Exception _innerException;

  ///
  /// ErrorData ctor
  ErrorData(String message, {Exception innerException:null})
  {
    _message = message;
    _innerException = innerException;
  }
  
  ///
  /// Get the error message
  String get Message
  {
    return _message;
  }
  
  ///
  /// Set the error message
  void set Message(value)
  {
    this._message = value;
  }
  
  ///
  /// Get 'inner' exception (if any)
  Exception get InnerException
  {
    return _innerException;
  }
  
  ///
  /// Set 'inner' exception
  void set InnerException(value)
  {
    _innerException = value;
  }
}