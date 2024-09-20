X, Y = map(int, input().strip().split())
x, y = map(int, input().strip().split())
M = int(input().strip()[0])

nope = False

if M < 1:
    print("Senshi makannya besok aja deh.")
else:
    if 0 < x < X - 1 and 0 < y < Y - 1:
        nope = M < 8
    elif 0 < x < X - 1 or 0 < y < Y - 1:
        nope = M < 5
    else:
        nope = M < 3

if nope:
    print("Senshi makan hari ini!")
else:
    print("Senshi makannya besok aja deh.")
