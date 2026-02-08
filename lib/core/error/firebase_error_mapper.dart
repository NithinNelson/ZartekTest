class FirebaseErrorMapper {
  static String map(String code) {
    switch (code) {
      case "BILLING_NOT_ENABLED":
        return "Firebase phone auth requires billing enabled.";
      case "invalid-phone-number":
        return "Invalid phone number.";
      case "too-many-requests":
        return "Too many attempts. Try later.";
      case "network-request-failed":
        return "Network error. Check internet connection.";
      default:
        return 'Firebase Message : $code';
    }
  }
}
