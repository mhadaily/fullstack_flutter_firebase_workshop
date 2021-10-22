num getCartItemTotal({
  required int count,
  required num price,
  required int additions,
  required int size,
  required int sugar,
}) {
  return count * price + additions * 3 + size * 1 + sugar * 0.5;
}
