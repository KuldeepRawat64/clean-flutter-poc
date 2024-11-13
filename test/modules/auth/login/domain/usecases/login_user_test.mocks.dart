// Mocks generated by Mockito 5.4.4 from annotations
// in clean_flutter_poc/test/modules/auth/login/domain/usecases/login_user_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:clean_flutter_poc/core/failure.dart' as _i5;
import 'package:clean_flutter_poc/modules/auth/login/domain/entities/login_response_item.dart'
    as _i6;
import 'package:clean_flutter_poc/modules/auth/login/domain/repositories/login_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LoginRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginRepository extends _i1.Mock implements _i3.LoginRepository {
  MockLoginRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.LoginResponseItem>> login_user(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #login_user,
          [
            email,
            password,
          ],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i6.LoginResponseItem>>.value(
                _FakeEither_0<_i5.Failure, _i6.LoginResponseItem>(
          this,
          Invocation.method(
            #login_user,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.LoginResponseItem>>);
}
