
part of simplechat_server;

/**
 *  Class will provide 'log' capabilites
 */
class LocalLogger
{
  /// Global logger
  Logger _logger = null; 
  
  /// File name of the log file
  String _logFileName;
  
  /// 'True' to log to console also, otherwise 'false'
  bool _ifLogToConsole = false;
  
  /**
   * Default ctor
   *     [logFileName] file name to save the log messages
   *     [logToConsole] 'true' to log to console also, otherwise 'false'
   */
  LocalLogger(String logFileName, [bool logToConsole=false])
  {
    this._logFileName = logFileName;
    this._ifLogToConsole = logToConsole;
  }
  
  /**
   * Function will set-up the [log4dart] logger
   * 
   * Return fully configured [Logger]
   */
  Logger _createLogger(String logFileName, bool logToConsole)
  {
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
    
   
    LoggerFactory.config[".*"].appenders = [ new FileAppender(logDir.path + "/" + logFileName) ];
    
//    + "SimpleChatServer" + 
//    "-" + _localDate.day.toString() + 
//    "-" + _localDate.month.toString() + 
//    "-" + _localDate.year.toString() + 
//    "_" + _localDate.hour.toString() + 
//    "-" + _localDate.minute.toString() +
//    "-" + _localDate.second.toString() +
//    ".log"
    
    if (_ifLogToConsole == true)
    {
      LoggerFactory.config[".*"].appenders.add(new ConsoleAppender());
    }
    
    return LoggerFactory.getLogger("SimpleChatServer_WebSocketServer");
  }  
  
  
  /**
   * Log 'information' message
   */
  void LogInfo(String message)
  {
    if (_logger == null)
    {
      _logger = _createLogger(this._logFileName, this._ifLogToConsole);
    }
    
    this._logger.info(message);
  }
  
  /**
   * Log error message
   */
  void LogError(String message)
  {
    if (_logger == null)
    {
      _logger = _createLogger(this._logFileName, this._ifLogToConsole);
    }
    
    _logger.error(message);
  }
}
