import 'package:flutter_test/flutter_test.dart';
import 'package:common_authorization/common_authorization.dart';

void main() {
  group('AuthorizationService', () {
    late AuthorizationService service;

    setUp(() {
      service = AuthorizationService();
    });

    test('sets user permissions and roles', () {
      final user = AppUser(
        id: '1',
        roles: const [
          AppRole(id: '1', code: 'ADMIN', name: 'Administrator'),
        ],
        permissions: const [
          AppPermission(code: 'patient.view', name: 'View Patients'),
        ],
      );

      service.setUser(user);

      expect(service.isAuthenticated, isTrue);
      expect(service.hasRole('ADMIN'), isTrue);
      expect(service.hasPermission('patient.view'), isTrue);
      expect(service.hasPermission('patient.delete'), isFalse);
    });

    test('applies allow and deny overrides', () {
      final user = AppUser(
        id: '1',
        permissions: const [
          AppPermission(code: 'patient.view', name: 'View Patients'),
          AppPermission(code: 'patient.delete', name: 'Delete Patients'),
        ],
        overrides: const [
          PermissionOverride(
            permission: 'patient.edit',
            effect: PermissionEffect.allow,
          ),
          PermissionOverride(
            permission: 'patient.delete',
            effect: PermissionEffect.deny,
          ),
        ],
      );

      service.setUser(user);

      expect(service.hasPermission('patient.edit'), isTrue);
      expect(service.hasPermission('patient.delete'), isFalse);
    });

    test('supports any and all checks', () {
      service.setPermissions([
        'patient.view',
        'patient.edit',
      ]);

      expect(
        service.hasAnyPermission([
          'patient.delete',
          'patient.view',
        ]),
        isTrue,
      );

      expect(
        service.hasAllPermissions([
          'patient.view',
          'patient.edit',
        ]),
        isTrue,
      );
    });

    test('clear removes authorization state', () {
      service.setPermissions(['patient.view']);
      service.setRoles(['ADMIN']);

      service.clear();

      expect(service.isAuthenticated, isFalse);
      expect(service.permissions, isEmpty);
      expect(service.roles, isEmpty);
    });
  });
}
