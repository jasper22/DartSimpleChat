
library simplechat_server;

import 'dart:io';
import 'dart:async';
import 'dart:json' as JSON;
import 'package:mongo_dart/mongo_dart.dart' as MONGO;
import 'package:log4dart/log4dart_vm.dart';
import 'package:DartSimpleChat_Shared/SimpleChatShared.dart';

//
// Server core librarires
part 'src/LocalLogger.dart';
part 'src/WebServerBase.dart';
part 'src/ErrorData.dart';
part 'src/WebSocketServer.dart';
part 'src/EventStream.dart';

//
// Database managment
part 'src/Database/DatabaseBase.dart';
part 'src/Database/MongoDatabase.dart';