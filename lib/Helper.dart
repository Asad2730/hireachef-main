class Helper {
  static late User loggedUser;
  static int type = 2;
}

class User {
  late String id, email, password, username, location, pic;
  late double rating;
  late int type;
}

class Notifications {
  late String dishName, time, url, userName, pic;
  late String id;
}

class Messages {
  late String from, id1, id2, msg, to;
  late int count;
}
