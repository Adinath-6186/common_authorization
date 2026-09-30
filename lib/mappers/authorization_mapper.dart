import '../models/app_user.dart';

abstract interface class AuthorizationMapper<T> {
  AppUser mapUser(T response);
}
