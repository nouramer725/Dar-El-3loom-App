import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../utils/global_dialogs.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;

  SocketService._internal();

  late IO.Socket socket;

  void connect() {
    socket = IO.io(
      "http://192.168.1.12:3000",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableReconnection()
          .build(),
    );

    socket.onConnect((_) {
      print("Socket connected");
    });

    socket.onDisconnect((_) {
      print("Socket disconnected");
    });

    socket.on('parent_notification', (data) {
      print("New parent notification: $data");

      showGlobalNotificationDialog(data);
    });
  }

  void disconnect() {
    socket.dispose();
  }
}
