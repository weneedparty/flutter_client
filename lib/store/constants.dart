class RoutesMap {
  static const welcome = "/welcome";
  static const register = "/register";
  static const registerVerifying = "/register_verifying";
  static const chatRoom = "/chat_room";
  static const roomList = "/room_list";
}

class GrpcConfig {
  static const hostIPAddress = "10.0.2.2";
  // static const hostIPAddress = "192.168.50.189";

  static const helloworldPortNumber = 40051;
  static const accountservicePortNumber = 40054;
  static const roomcontrolservicePortNumber = 40055;
}
