import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  static String? token;

  factory SocketService() {
    return _instance;
  }

  SocketService._internal();

  late IO.Socket socket;

  void connect() {
    socket = IO.io(
      "http://192.168.1.12:3000", // ضع هنا عنوان السيرفر بتاعك
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) => print("Socket connected"));
    socket.onDisconnect((_) => print("Socket disconnected"));
    socket.onError((err) => print("Socket error: $err"));

    socket.connect();

    socket.onConnect((_) {
      print("Socket connected");
    });

    socket.onDisconnect((_) {
      print("Socket disconnected");
    });
  }
}
