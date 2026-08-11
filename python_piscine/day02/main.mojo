"""Day 02 — pure-Mojo status table drill (no network)."""

def main():
    var codes: List[Int] = [200, 201, 301, 404, 500]
    var names: List[String] = [
        "OK",
        "Created",
        "Moved Permanently",
        "Not Found",
        "Internal Server Error",
    ]
    var i = 0
    while i < len(codes):
        print(codes[i], names[i])
        i += 1
