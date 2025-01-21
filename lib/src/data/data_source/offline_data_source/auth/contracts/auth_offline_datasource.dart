abstract interface class AuthOfflineDataSource {
  Future<bool> isLoggedUser();

  Future<void> saveToken(String token);

  Future<void> deleteToken();
  Future<String?> getToken();
  Future<void> onBoardingCompleted();
  Future<bool> isOnBoardingCompleted();
}
