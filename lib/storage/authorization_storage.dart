import '../models/authorization_state.dart';

abstract interface class AuthorizationStorage {
  Future<void> save(AuthorizationState state);
  Future<AuthorizationState?> load();
  Future<void> clear();
}
