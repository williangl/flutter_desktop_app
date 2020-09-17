import 'package:flutter/foundation.dart';

import '../core/protection_manager.dart';
import '../core/win/tasklist.dart';
import '../core/manager.dart';

class WindowsManager extends Manager with ProtectionManager {
  String processName;
  String serviceName;
  String dllPath;

  WindowsManager({
    @required this.processName,
    @required this.serviceName,
    @required this.dllPath,
  });

  @override
  Future<int> processes() async {
    return await countProcessByName(processName);
  }

  @override
  Future<bool> start() {
    // TODO: implement start
    throw UnimplementedError();
  }

  @override
  Future<bool> stop() {
    // TODO: implement stop
    throw UnimplementedError();
  }

  @override
  Future<bool> stopFileProtection() {
    // TODO: implement stopFileProtection
    throw UnimplementedError();
  }
}
