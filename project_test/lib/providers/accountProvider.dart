import 'package:Memo/database/datebase.dart';
import 'package:Memo/database/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';

class AccountProvider extends ChangeNotifier {
  int _currentUserId = -1;
  String _username = 'user1@gmail.com';
  String _email = '';
  String _password = '';
  User? _currentUser;
  bool _isLoggedIn = false;

  String get username => _username;
  String get email => _email;
  String get password => _password;
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  int get currentUserId => _currentUserId;

  AccountProvider() {
    loadUserData();
  }
  Future<void> loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      _isLoggedIn = isLoggedIn;
      if (isLoggedIn) {
        final savedEmail = prefs.getString('email') ?? '';
        final savedPassword = prefs.getString('password') ?? '';

        if (savedEmail.isNotEmpty && savedPassword.isNotEmpty) {
          final user = await dB.loginUser(savedEmail, savedPassword);
          if (user != null) {
            _currentUser = user;
            _username = user.username;
            _email = user.email;
            _password = user.password;
            _isLoggedIn = true;
            _currentUserId = user.id!;
            notifyListeners();
          } else {
            await _clearUserData();
          }
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
      await _clearUserData();
    }
  }

  Future<void> _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('email');
    await prefs.remove('password');
    await prefs.remove('username');
    _isLoggedIn = false;
    _username = '';
    _email = '';
    _password = '';
    _currentUser = null;
    _currentUserId = -1;
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', _isLoggedIn);
    await prefs.setString('email', _email);
    await prefs.setString('password', _password);
    await prefs.setString('username', _username);
  }

  final SqlDb dB = SqlDb();

  void setUsername(String username) {
    dB.updateUser(
      User(
        id: _currentUserId,
        username: username,
        email: _email,
        password: _password,
      ),
    );
    _username = username;
    notifyListeners();
    _saveUserData();
  }

  void setIsLoggedIn(bool newLoginState) {
    _isLoggedIn = newLoginState;
    notifyListeners();
    _saveUserData();
  }

  void setEmail(String email) {
    dB.updateUser(
      User(
        id: _currentUserId,
        username: _username,
        email: email,
        password: _password,
      ),
    );
    _email = email;
    notifyListeners();
    _saveUserData();
  }

  void setPassword(String password) {
    dB.updateUser(
      User(
        id: _currentUserId,
        username: _username,
        email: _email,
        password: password,
      ),
    );
    _password = password;
    notifyListeners();
    _saveUserData();
  }

  Future<bool> register(User user) async {
    try {
      if (await dB.userExists(user.email)) {
        return false;
      }

      final userId = await dB.insertUser(user);
      if (userId > 0) {
        final newUser = await dB.loginUser(user.email, user.password);
        if (newUser != null) {
          _currentUser = newUser;
          _username = newUser.username;
          _email = newUser.email;
          _password = newUser.password;
          _isLoggedIn = true;
          _currentUserId = newUser.id!;
          await _saveUserData();
          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      print('Error in register: $e');
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final user = await dB.loginUser(email, password);
      if (user != null) {
        _currentUser = user;
        _username = user.username;
        _email = user.email;
        _password = user.password;
        _isLoggedIn = true;
        _currentUserId = user.id!;
        await _saveUserData();
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Error in login: $e');
      return false;
    }
  }

  void logout() async {
    _currentUser = null;
    _username = '';
    _email = '';
    _password = '';
    _isLoggedIn = false;
    _currentUserId = -1;

    await _clearUserData();
    notifyListeners();
  }

  Future<bool> updateUsername(String newUsername) async {
    try {
      if (_currentUser != null) {
        final updatedUser = User(
          id: _currentUser!.id,
          username: newUsername,
          email: _currentUser!.email,
          password: _currentUser!.password,
        );

        final db = await dB.database;
        await db.rawUpdate(
          '''
          UPDATE users SET username = ? WHERE id = ?
        ''',
          [newUsername, _currentUser!.id],
        );

        _username = newUsername;
        _currentUser = updatedUser;

        await _saveUserData();
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Error updating username: $e');
      return false;
    }
  }

  Future<bool> updateEmail(String newEmail) async {
    try {
      if (_currentUser != null) {
        if (await dB.userExists(newEmail) && newEmail != _currentUser!.email) {
          return false;
        }

        final updatedUser = User(
          id: _currentUser!.id,
          username: _currentUser!.username,
          email: newEmail,
          password: _currentUser!.password,
        );

        final db = await dB.database;
        await db.rawUpdate(
          '''
          UPDATE users SET email = ? WHERE id = ?
        ''',
          [newEmail, _currentUser!.id],
        );

        _email = newEmail;
        _currentUser = updatedUser;

        await _saveUserData();
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Error updating email: $e');
      return false;
    }
  }

  Future<bool> updatePassword(String oldPassword, String newPassword) async {
    try {
      if (_currentUser != null) {
        if (_currentUser!.password != oldPassword) {
          return false;
        }

        final updatedUser = User(
          id: _currentUser!.id,
          username: _currentUser!.username,
          email: _currentUser!.email,
          password: newPassword,
        );

        final db = await dB.database;
        await db.rawUpdate(
          '''
          UPDATE users SET password = ? WHERE id = ?
          ''',
          [newPassword, _currentUser!.id],
        );

        _password = newPassword;
        _currentUser = updatedUser;

        await _saveUserData();
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print('Error updating password: $e');
      return false;
    }
  }

  Future<bool> deleteAccount() async {
    try {
      if (_currentUser != null) {
        final db = await dB.database;
        await db.rawDelete(
          '''
          DELETE FROM users WHERE id = ?
          ''',
          [_currentUser!.id],
        );

        logout();
        await _clearUserData();
        return true;
      }
      return false;
    } catch (e) {
      print('Error deleting account: $e');
      return false;
    }
  }
}
