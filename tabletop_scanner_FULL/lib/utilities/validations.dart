String? validateRequiredText(String? text) {
  if (text == null || text.trim().isEmpty) {
    return 'This field is required.';
  }
  return null;
}
