"""Tiny 1-D k-means (k=2) for illustration."""

def main():
    var pts: List[Float64] = [1.0, 1.2, 0.8, 5.0, 5.5, 4.8, 5.1]
    var c0 = pts[0]
    var c1 = pts[len(pts) - 1]
    var round_i = 0
    while round_i < 10:
        var s0 = Float64(0.0)
        var s1 = Float64(0.0)
        var n0 = 0
        var n1 = 0
        var i = 0
        while i < len(pts):
            var d0 = pts[i] - c0
            if d0 < 0:
                d0 = -d0
            var d1 = pts[i] - c1
            if d1 < 0:
                d1 = -d1
            if d0 <= d1:
                s0 += pts[i]
                n0 += 1
            else:
                s1 += pts[i]
                n1 += 1
            i += 1
        if n0 > 0:
            c0 = s0 / Float64(n0)
        if n1 > 0:
            c1 = s1 / Float64(n1)
        round_i += 1
    print("centroids:", c0, c1)
