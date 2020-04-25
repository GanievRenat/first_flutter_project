import 'package:FlutterGalleryApp/models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  User registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);
    if (!users.containsKey(user.login)) {
      users[user.login] = user;
      return user;
    } else {
      throw Exception('A user with this email already exists');
    }
  }

  /*
  * Реализуй метод registerUserByEmail(String fullName, String email) возвращающий объект User,
  * если пользователь с таким же логином уже есть в системе необходимо бросить исключение
  * Exception('A user with this email already exists')*/

  User registerUserByEmail(String fullName, String email) {
    User user = User(name: fullName, email: email);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
      return user;
    } else {
      throw Exception('A user with this email already exists');
    }
  }

  /*
  * Реализуй метод registerUserByPhone(String fullName, String phone) возвращающий объект User,
  * если пользователь с таким же телефоном уже есть в системе необходимо бросить ошибку
  * Exception('A user with this phone already exists') валидным является любой номер телефона содержащий первым символом + и 11 цифр
  * и не содержащий буквы, иначе необходимо бросить исключение Exception("Enter a valid phone number starting with a + and containing 11 digits"),
  * а также выполнить проверку на то что поле phone не пустое и не null. Иначе необходимо бросить исключение Exception('Enter don't empty phone number')
  * */

  User registerUserByPhone(String fullName, String phone) {
    User user = User(name: fullName, phone: phone);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
      return user;
    } else {
      throw Exception('A user with this phone already exists');
    }
  }

  /*
  Реализуй метод findUserInFriends(String fullName, User user) возвращающий объект User.
  Метод должен найти (user) среди друзей пользователя (fullName).
  Если пользователь не найден, то необходимо бросить ошибку Exception(${user.login} is not a friend of the login)
  * */

  User findUserInFriends(String login, User user) {
    /*for (var item in users.entries) {
      // item представляет MapEntry<K, V>
      if (item.value.name == fullName) {
        return item.value.findMyFrend(user);
      }
    }*/
    if (users.containsKey(login)) {
      User userForLogin = users[login];
      return userForLogin.findMyFrend(user);
    } else {
      throw Exception('A user with this login already exists');
    }
  }

  List<User> importUsers(List<String> list) {
    List<User> importListNewUser = [];

    for (String userInfo in list) {
      List<String> futureUser = userInfo.trim().split(";");
      if (futureUser.length >= 3) {
        try {
          User u = registerUser(futureUser[0].trim(), futureUser[2].trim(), futureUser[1].trim());
          importListNewUser.add(u);
        } catch (text) {
          print(text);
        }
      }
    }
    return importListNewUser;
  }

  User getUserByLogin(String login) {
    if (users.containsKey(login)) {
      return users[login];
    } else {
      throw Exception('A user with this login already exists');
    }
  }

  void setFriends(String login, List<User> friends) {
    if (users.containsKey(login)) {
      users[login].addFriend(friends);
    } else {
      throw Exception('A user with this login already exists');
    }
  }
}
