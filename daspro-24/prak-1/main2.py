X, Y = map(int, input().strip().split())
x, y = map(int, input().strip().split())
M = int(input().strip())
monsters = [list(map(int, input().strip().split())) for m in range(M)]

if M < 1:
    print("Senshi makannya besok aja deh.")
else:
    if 0 < x < X - 1 and 0 < y < Y - 1:
        if (
            all(
                (mx != x or my != y)
                and (mx == x - 1 or mx == x + 1 or mx == x)
                and (my == y - 1 or my == y + 1 or my == y)
                for mx, my in monsters
            )
            and len(monsters) >= 8
        ):
            print("Senshi makannya besok aja deh.")
        else:
            print("Senshi makan hari ini!")
    elif 0 < x < X - 1 or 0 < y < Y - 1:
        if (
            all(
                (mx != x or my != y)
                and (mx == x - 1 or mx == x + 1 or mx == x)
                and (my == y - 1 or my == y + 1 or my == y)
                for mx, my in monsters
            )
            and len(monsters) >= 5
        ):
            print("Senshi makannya besok aja deh.")
        else:
            print("Senshi makan hari ini!")
    else:
        if (
            all(
                (mx != x or my != y)
                and (mx == x - 1 or mx == x + 1 or mx == x)
                and (my == y - 1 or my == y + 1 or my == y)
                for mx, my in monsters
            )
            and len(monsters) >= 3
        ):
            print("Senshi makannya besok aja deh.")
        else:
            print("Senshi makan hari ini!")
