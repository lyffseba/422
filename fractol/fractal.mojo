"""fractol — Mandelbrot / Julia ASCII (and optional PGM) renderer."""

from libft.string import ft_itoa, byte_at

def mandelbrot_cell(cx: Float64, cy: Float64, max_iter: Int) -> Int:
    var x = Float64(0.0)
    var y = Float64(0.0)
    var i = 0
    while i < max_iter:
        if x * x + y * y > 4.0:
            return i
        var nx = x * x - y * y + cx
        y = 2.0 * x * y + cy
        x = nx
        i += 1
    return max_iter

def julia_cell(zx: Float64, zy: Float64, cx: Float64, cy: Float64, max_iter: Int) -> Int:
    var x = zx
    var y = zy
    var i = 0
    while i < max_iter:
        if x * x + y * y > 4.0:
            return i
        var nx = x * x - y * y + cx
        y = 2.0 * x * y + cy
        x = nx
        i += 1
    return max_iter

def shade(v: Int, max_iter: Int) -> String:
    if v >= max_iter:
        return "#"
    var ramp = " .:-=+*#%@"
    var idx = (v * (ramp.byte_length() - 1)) // max_iter
    return String(chr(byte_at(ramp, idx)))

def render_mandelbrot(width: Int = 80, height: Int = 30, max_iter: Int = 40) -> String:
    var out = String()
    var y = 0
    while y < height:
        var x = 0
        while x < width:
            var cx = (Float64(x) / Float64(width)) * 3.5 - 2.5
            var cy = (Float64(y) / Float64(height)) * 2.0 - 1.0
            var v = mandelbrot_cell(cx, cy, max_iter)
            out += shade(v, max_iter)
            x += 1
        out += "\n"
        y += 1
    return out^

def render_julia(width: Int = 80, height: Int = 30, max_iter: Int = 40,
                 jx: Float64 = -0.8, jy: Float64 = 0.156) -> String:
    var out = String()
    var y = 0
    while y < height:
        var x = 0
        while x < width:
            var zx = (Float64(x) / Float64(width)) * 3.0 - 1.5
            var zy = (Float64(y) / Float64(height)) * 2.0 - 1.0
            var v = julia_cell(zx, zy, jx, jy, max_iter)
            out += shade(v, max_iter)
            x += 1
        out += "\n"
        y += 1
    return out^

def render_pgm(width: Int, height: Int, max_iter: Int) -> String:
    """Portable Graymap for external viewers."""
    var out = String("P2\n")
    out += ft_itoa(width)
    out += " "
    out += ft_itoa(height)
    out += "\n"
    out += ft_itoa(max_iter)
    out += "\n"
    var y = 0
    while y < height:
        var x = 0
        while x < width:
            var cx = (Float64(x) / Float64(width)) * 3.5 - 2.5
            var cy = (Float64(y) / Float64(height)) * 2.0 - 1.0
            var v = mandelbrot_cell(cx, cy, max_iter)
            out += ft_itoa(v)
            out += " "
            x += 1
        out += "\n"
        y += 1
    return out^
