import 'authorization_storage.dart';
import '../models/authorization_state.dart';

class MemoryAuthorizationStorage implements AuthorizationStorage {
  AuthorizationState? _state;

  @override
  Future<void> save(AuthorizationState state) async {
    _state = state;
  }

  @override
  Future<AuthorizationState?> load() async => _state;

  @override
  Future<void> clear() async {
    _state = null;
  }
}
