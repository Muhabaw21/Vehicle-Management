class ApIConfig {
  static const String urlAPI = "164.90.174.113:9090";
  static const unload = "/Api/Driver/ChangeDriverState";
  static const ownerinfoupdate = "/Api/Vehicle/UpdateInfo";

  static const String acceptwork = "/Api/Driver/All/Cargos/ACCEPTED";

  static const ownerlogo = "http://164.90.174.113:9090/Api/Admin/LogoandAvatar";
  static const aviablemarketfordriver =
      'http://164.90.174.113:9090/Api/Vehicle/All/Market';
  static const String aviablemarket = "/Api/Vehicle/All/Market";
  static const String drverInfo = "/Api/Driver/Info";
  static const String forgetpin = "/Api/User/GeneratePIN";
  static const String ownerInfo = "/Api/Vehicle/Owner/Info";

  static const String logo =
      "http://164.90.174.113:9090/Api/Admin/LogoandAvatar";
  static String assignDriverApi =
      "http://164.90.174.113:9090/Api/Vehicle/AssignDriver";
  static String changeDriverStatus =
      "http://164.90.174.113:9090/Api/Vehicle/ChangeDriverStatus";
  static String changeVehicleStatus =
      "http://164.90.174.113:9090/Api/Vehicle/SetStatus";
  static const String alertforowner =
      "http://164.90.174.113:9090/Api/Vehicle/Alerts/ByStatus";

  static const String allvehicle =
      "http://164.90.174.113:9090/Api/Vehicle/Owner/All";
  static const String driverApi = "/Api/Vehicle/Owner/Drivers/All";
  static const String getalert = "/Api/Driver/Alerts/ByStatus";
  static const String corgaStatus = "/Api/Driver/All/Cargos/ACCEPT";
  static const String logIn = "/Api/SignIn/Owner";
  static const String vehiclebystatus =
      "http://164.90.174.113:9090/Api/Vehicle/Owner/Status";
  static const String tripOptions = "/Api/Admin/TripType/All";
  static const String setTrip =
      "http://164.90.174.113:9090/Api/Admin/CreateTrip";
  static const String activeTrip =
      "http://164.90.174.113:9090/Api/Vehicle/Trip/All";
  static const String creatTrip =
      "http://164.90.174.113:9090/Api/Admin/CreateTrip";
  static const String avaiableTrip =
      "http://164.90.174.113:9090/Api/Vehicle/All/Driver";

  static const String updatedriverprofile = "/Api/Driver/UpdateInfo";
}
