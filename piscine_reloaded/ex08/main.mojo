from std.sys.arg import argv

def main():
    var args = argv()
    if len(args) == 1:
        print("Empty")
    else:
        print("Args present")
