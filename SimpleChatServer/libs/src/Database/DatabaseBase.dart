
part of simplechat_server;

/**
 *  Base class for all object that could manipulate database
 */
abstract class DatabaseBase
{
  String _serverAddress;
  
  String _userName;
  
  String _password;
  
  int _dbPort;
  
  String _databaseName;
  
  static const String DB_MESSAGES_TABLE_NAME = "tblMessages";
  
  /**
  * Default [DatabaseBase] object constructor
  * All parameters are optional
  *       [serverAddress] IP or Host address of database server
  *       [userName] User name to connect with
  *       [password] Password of user (if any user defined)
  *       [dbPort]  Port of database
  *       [databaseName]  Name of database to connect to
  */
  DatabaseBase([String serverAddress = null, String userName = null, String password = null, int dbPort = null, String databaseName = null])
  {
    this._databaseName = databaseName;
    this._dbPort = dbPort;
    this._password = password;
    this._serverAddress = serverAddress;
    this._userName = userName;
  }
  
  /**
   *  Get IP/Host of the database server
   */
  String get ServerAddress
  {
    return _serverAddress;
  }
  
  /**
   *  Get the user name used for connection (if any)
   */
  String get UserName
  {
    return _userName;
  }
  
  /**
   * Get password used for connection (if any)
   */
  String get Password
  {
    return _password;
  }
  
  /**
   * Get database port used for connection
   */
  int get DbPort
  {
    return _dbPort;
  }
  
  /**
   * Get the database name
   */
  String get DatabaseName
  {
    return _databaseName;
  }
  
  /**
   * Function will insert new message to database
   */
  Future AddMessage(SimpleMessage message);
}