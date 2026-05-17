import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/storage/secure_storage.dart';

enum AuthStatus { unauthenticated, authenticating, authenticated, error }

class AuthState {
  final AuthStatus status;
  final String? error;
  final String? email;

  const AuthState({
    this.status = AuthStatus.unauthenticated,
    this.error,
    this.email,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? error,
    String? email,
  }) {
    return AuthState(
      status: status ?? this.status,
      error: error,
      email: email ?? this.email,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final SecureStorage _storage;

  AuthNotifier(this._storage) : super(const AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(status: AuthStatus.authenticating, error: null);

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // In production, replace with real API call
      // For now, accept any valid credentials
      final token = _generateToken(email);

      await _storage.write(AppConstants.tokenKey, token);
      await _storage.write(AppConstants.userKey, email);

      state = state.copyWith(
        status: AuthStatus.authenticated,
        email: email,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: 'Login failed. Please try again.',
      );
    }
  }

  Future<void> signup(String email, String password) async {
    state = state.copyWith(status: AuthStatus.authenticating, error: null);

    try {
      await Future.delayed(const Duration(seconds: 1));

      final token = _generateToken(email);

      await _storage.write(AppConstants.tokenKey, token);
      await _storage.write(AppConstants.userKey, email);

      state = state.copyWith(
        status: AuthStatus.authenticated,
        email: email,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: 'Sign up failed. Please try again.',
      );
    }
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(status: AuthStatus.authenticating, error: null);

    try {
      // TODO: Implement Google Sign-In
      // final googleUser = await GoogleSignIn().signIn();
      // if (googleUser != null) { ... }
      await Future.delayed(const Duration(seconds: 1));

      state = state.copyWith(
        status: AuthStatus.authenticated,
        email: 'user@gmail.com',
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: 'Google sign-in failed.',
      );
    }
  }

  Future<void> signInWithApple() async {
    state = state.copyWith(status: AuthStatus.authenticating, error: null);

    try {
      // TODO: Implement Apple Sign-In
      await Future.delayed(const Duration(seconds: 1));

      state = state.copyWith(
        status: AuthStatus.authenticated,
        email: 'user@icloud.com',
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: 'Apple sign-in failed.',
      );
    }
  }

  Future<void> checkAuthStatus() async {
    final token = await _storage.read(AppConstants.tokenKey);
    final email = await _storage.read(AppConstants.userKey);

    if (token != null && email != null) {
      state = state.copyWith(
        status: AuthStatus.authenticated,
        email: email,
      );
    }
  }

  Future<void> logout() async {
    await _storage.delete(AppConstants.tokenKey);
    await _storage.delete(AppConstants.userKey);
    state = const AuthState();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  String _generateToken(String email) {
    final bytes = email.codeUnits;
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return 'tok_${hex}_${DateTime.now().millisecondsSinceEpoch}';
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return AuthNotifier(storage);
});
