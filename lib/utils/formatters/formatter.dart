class TFormatter {
  static String convertPhoneNumberToEmail(String formattedPhoneNumber,
      [String domain = 'client.com']) {
    // Remove all non-digit characters from the phone number
    String phoneNumber = formattedPhoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    // Add the desired domain (e.g., @client.com) to the converted phone number
    return '+$phoneNumber@$domain';
  }

  static String deConvertEmailToPhoneNumber(String email) {
    // Split the email address by '@' to separate the phone number part
    List<String> parts = email.split('@');
    if (parts.length != 2) {
      throw ArgumentError('Invalid email format');
    }

    // Remove any non-digit characters from the phone number part
    String phoneNumber = parts[0].replaceAll(RegExp(r'[^\d]'), '');

    // Format the phone number as needed
    String formattedPhoneNumber =
        '+998 ${phoneNumber.substring(0, 2)} ${phoneNumber.substring(2, 5)}-${phoneNumber.substring(5, 7)}-${phoneNumber.substring(7)}';

    return formattedPhoneNumber;
  }
}
