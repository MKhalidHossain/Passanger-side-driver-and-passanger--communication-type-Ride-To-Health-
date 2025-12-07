import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  static final SocketClient _instance = SocketClient._internal();
  factory SocketClient() => _instance;
  SocketClient._internal();

  IO.Socket? _socket;
  bool _isConnected = false;

  bool get isConnected => _isConnected;
  IO.Socket? get socket => _socket;

  /// Connect to socket server
  void connect({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? auth,
    bool autoConnect = true,
    Duration timeout = const Duration(seconds: 10),
  }) {
    try {
      final builder = IO.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery(query ?? {})
          .setAuth(auth ?? {})
          .setTimeout(timeout.inMilliseconds);

      if (!autoConnect) {
        builder.disableAutoConnect();
      }

      _socket = IO.io(
        url,
        builder.build(),
      );

      _socket?.onConnect((_) {
        _isConnected = true;
        print('✅ Socket connected');
      });

      _socket?.onDisconnect((_) {
        _isConnected = false;
        print('❌ Socket disconnected');
      });

      _socket?.onConnectError((error) {
        print('⚠️ Connection error: $error');
      });

      _socket?.onError((error) {
        print('⚠️ Socket error: $error');
      });

      if (autoConnect) {
        _socket?.connect();
      }
    } catch (e) {
      print('⚠️ Socket connection failed: $e');
    }
  }

  /// Manually connect if autoConnect was false
  void manualConnect() {
    _socket?.connect();
  }

  /// Join a room
  void join(String room, {Map<String, dynamic>? data}) {
    if (_socket != null && _isConnected) {
      emit('join', {'room': room, ...?data});
      print('🚪 Joined room: $room');
    } else {
      print('⚠️ Cannot join room. Socket not connected.');
    }
  }

  /// Emit an event
  void emit(String event, [dynamic data]) {
    if (_socket != null && _isConnected) {
      _socket!.emit(event, data);
      print('📤 Emitted: $event');
    } else {
      print('⚠️ Cannot emit. Socket not connected.');
    }
  }

  /// Listen to an event
  void on(String event, Function(dynamic) callback) {
    _socket?.on(event, callback);
    print('👂 Listening to: $event');
  }

  /// Remove listener for an event
  void off(String event) {
    _socket?.off(event);
    print('🔇 Stopped listening to: $event');
  }

  /// Disconnect socket
  void disconnect() {
    _socket?.disconnect();
    _isConnected = false;
    print('🔌 Socket disconnected');
  }

  /// Dispose and clean up
  void dispose() {
    _socket?.dispose();
    _socket = null;
    _isConnected = false;
    print('🗑️ Socket disposed');
  }
}