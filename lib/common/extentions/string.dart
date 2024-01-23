extension StringX on String {
  String getFileExtension() {
    try {
      return ".${split('.').last}";
    } catch (e) {
      return '.jpg';
    }
  }
}
