mixin ValidationMixin {
  String? validateNullEmpty(String name, String? value) {
    if (value?.isEmpty == true || value == null) {
      return '$name is Required';
    }
    return null;
  }
}
