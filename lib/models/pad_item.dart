enum PadType { number, operator, clear, answer, sign, percentage }

class PadItem {
  final String label;
  final PadType type;

  const PadItem({required this.label, required this.type});
}
