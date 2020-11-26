import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemotConf {
  static get instance => _singleton;
  static final RemotConf _singleton = RemotConf._internal();
  RemoteConfig remoteConfig;
  factory RemotConf() {
    return _singleton;
  }
  RemotConf._internal() {
    _initState();
  }

  _initState() async {
    remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch(expiration: const Duration(hours: 1));
    await remoteConfig.activateFetched();
  }

  String getUrl(String key) {
    return remoteConfig.getString(key);
  }

  Future setUrl(String key, String value) async {
    final defaults = <String, dynamic>{key: value};
    await remoteConfig.setDefaults(defaults);
  }
}
