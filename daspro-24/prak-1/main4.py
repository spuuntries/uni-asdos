X, Y = map(int, input().split())
x, y = map(int, input().split())
monsters = [tuple(map(int, input().strip().split())) for m in range(int(input()))]
# fmt: off
if not len(monsters):
    print("Senshi makannya besok aja deh.")
else:
    ap = [(x + i % 3 - 1, y + i // 3 - 1) for i in range(9) if i - 4]
    res = list(filter(lambda m: m in ap, monsters))
    lt = len(res)
    if lt > max(2, 4 * (0 < x < X - 1 or 0 < y < Y - 1), 7 * (0 < x < X - 1 and 0 < y < Y - 1)):  
        # Boolean itu ekivalen dengan integer 0 dan 1 di python
        print("Senshi makannya besok aja deh.")
    else:
        print("Senshi makan hari ini!")
