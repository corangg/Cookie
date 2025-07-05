class Pair<A, B> {
  final A first;
  final B second;

  const Pair(this.first, this.second);

  @override
  bool operator ==(Object other) =>
      other is Pair<A, B> && other.first == first && other.second == second;

  @override
  int get hashCode => Object.hash(first, second);

  @override
  String toString() => 'Pair($first, $second)';
}
