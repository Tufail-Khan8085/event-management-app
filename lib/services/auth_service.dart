class AuthService {
  // Local state test karne ke liye
  static bool _isLoggedIn = false;

  // Frontend Mock Signup
  Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    // 1 second ka artificial delay (UI loading test karne ke liye)
    await Future.delayed(const Duration(seconds: 1));
    _isLoggedIn = true;
    return true;
  }

  // Frontend Mock Login
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    _isLoggedIn = true;
    return true;
  }

  // Frontend Mock Logout
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _isLoggedIn = false;
  }

  // Check user logged in status
  bool get isLoggedIn => _isLoggedIn;
}