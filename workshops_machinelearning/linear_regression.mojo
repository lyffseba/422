"""Ordinary least squares for y = a*x + b on a toy dataset."""

def main():
    # x = 1..5, y = 2x + 1
    var xs: List[Float64] = [1.0, 2.0, 3.0, 4.0, 5.0]
    var ys: List[Float64] = [3.0, 5.0, 7.0, 9.0, 11.0]
    var n = Float64(len(xs))
    var sum_x = Float64(0.0)
    var sum_y = Float64(0.0)
    var sum_xx = Float64(0.0)
    var sum_xy = Float64(0.0)
    var i = 0
    while i < len(xs):
        sum_x += xs[i]
        sum_y += ys[i]
        sum_xx += xs[i] * xs[i]
        sum_xy += xs[i] * ys[i]
        i += 1
    var den = n * sum_xx - sum_x * sum_x
    var a = (n * sum_xy - sum_x * sum_y) / den
    var b = (sum_y - a * sum_x) / n
    print("a ≈", a, "b ≈", b)
    print("pred x=10 ->", a * 10.0 + b)
