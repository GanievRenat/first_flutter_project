mixin UserUtil {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();
}

enum LoginType { email, phone }

class User with UserUtil {
  String email;
  String phone;
  String _lastName;
  String _firstName;
  LoginType _type;

  List<User> friends = [];

  User._({String firstName, String lastName, String phone, String email})
      : _firstName = firstName,
        _lastName = lastName,
        this.phone = phone,
        this.email = email {
    _type = ((email != null) && (email.isNotEmpty)) ? _type = LoginType.email : _type = LoginType.phone;
  }

  factory User({String name, String phone, String email}) {
    (name == null) ? name = "" : name = name;
    (phone == null) ? phone = "" : phone = phone;
    (email == null) ? email = "" : email = email;

    if (name.isEmpty) throw Exception("User name is empty");
    if (name.indexOf(' ') == 0) throw Exception("Indicate first name and last name");
    if (email.isEmpty && phone.isEmpty) throw Exception("Phone or Email is empty");

    return User._(
        firstName: _getFirstName(name),
        lastName: _getLastName(name),
        phone: ((phone != null) && (phone.isNotEmpty)) ? checkPhone(phone) : phone,
        email: ((email != null) && (email.isNotEmpty)) ? checkEmail(email) : email);
  }

  static String _getLastName(String userName) => userName.split(" ")[1];
  static String _getFirstName(String userName) => userName.split(" ")[0];
  static String checkPhone(String phone) {
    String pattern = "ˆ?[+0]?[0-9]{11}";
    phone = phone.replaceAll(RegExp("[^+0-9]"), "");

    if ((phone == null) || (phone.isEmpty)) {
      throw Exception("Enter don't empty phone number");
    } else if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception("Enter a valid phone number starting with a + and containing 11 digits");
    }
    return phone;
  }

  static String checkEmail(String email) {
    if ((email == null) || (email.isEmpty)) {
      throw Exception("Enter don't empty email");
    }
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    if (!RegExp(pattern).hasMatch(email)) {
      throw Exception("Enter a valid email");
    }
    return email;
  }

  String get login {
    if (_type == LoginType.email)
      return email;
    else
      return phone;
  }

  String get name => '${capitalize(_firstName)} ${capitalize(_lastName)}';

  @override
  String toString() {
    // TODO: implement toString
    return '''
     name: $name
     email: $email
     friends: ${friends.toList()}
  ''';
  }

  @override
  bool operator ==(Object object) {
    if (object == null) return false;
    if (object is User) {
      return _firstName == object._firstName &&
          _lastName == object._lastName &&
          (phone == object.phone || email == object.email);
    }
    return false;
  }

  void addFriend(Iterable<User> newFirend) {
    friends.addAll(newFirend);
  }

  void removeFriend(User user) {
    friends.remove(user);
  }

  User findMyFrend(User user) {
    for (var myFrend in friends) {
      if (myFrend == user) {
        return myFrend;
      }
    }
    throw Exception('${user.login} is not a friend of the login');
  }
}
