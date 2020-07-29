class Validate {
  static isNon(String value) {
    return value == null || value.isEmpty;
  }

  static checkMobile(String value) {
    if (value == null || value.isEmpty) {
      return '请输入手机号';
    } else {
      const regExp = r"^1[3456789]\d{9}$";
      if (!RegExp(regExp).hasMatch(value)) {
        return '手机号格式错误';
      }
    }
    return null;
  }
}
