import 'package:readily/folder/user_model.dart';
import 'package:rxdart/rxdart.dart';

class AppState {
  final BehaviorSubject<UserModel?> _user = BehaviorSubject<UserModel?>();

  UserModel? get loggedInUser => _user.value;

  set loggedInUser(UserModel? user) {
    _user.value = user;
  }

  ValueStream<UserModel?> getStreamOfUserChanges() {
    return _user.stream;
  }
}
