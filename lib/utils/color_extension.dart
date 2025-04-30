import 'dart:ui';

extension ColorExtension on Color {
  String colorToHex(Color color, {bool leadingHashSign = true}) {
    return '${leadingHashSign ? '#' : ''}'
        '${color.alpha.toRadixString(16).padLeft(2, '0')}'
        '${color.red.toRadixString(16).padLeft(2, '0')}'
        '${color.green.toRadixString(16).padLeft(2, '0')}'
        '${color.blue.toRadixString(16).padLeft(2, '0')}';
  }
}

extension StringExtension on String {
  Color toColor() {
    final hex = replaceAll('#', '').toUpperCase();

    if (hex.length == 6) {
      // Nếu thiếu alpha, thêm FF (full opacity)
      return Color(int.parse('FF$hex', radix: 16));
    } else if (hex.length == 8) {
      // Đã đầy đủ ARGB
      return Color(int.parse(hex, radix: 16));
    } else {
      throw FormatException("Invalid color hex string: $this");
    }
  }
}
