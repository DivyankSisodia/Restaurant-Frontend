// address_helper.dart

// ignore_for_file: file_names

class AddressHelper {
  static String getShortAddress(String address) {
    List<String> addressParts = address.split(',');
    if (addressParts.length >= 2) {
      return addressParts[0].trim();
    } else {
      return address;
    }
  }

  static String getRemainingAddress(String address) {
    List<String> addressParts = address.split(',');
    if (addressParts.length >= 2) {
      return addressParts[1];
    } else {
      return ''; // Set remainingAddress to an empty string
    }
  }
}
