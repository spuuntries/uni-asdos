X, Y = map(int, input().strip().split())
x, y = map(int, input().strip().split())
M = int(input().strip()[0])

n1 = False
n2 = False
n3 = False
n4 = False
n5 = False
n6 = False
n7 = False
n8 = False

if M > 1:
    if 0 < x < X - 1 and 0 < y < Y - 1:
        if M >= 1:
            nx, ny = map(int, input().strip().split())
            n1 = (
                (nx != x or ny != y)
                and (nx == x - 1 or nx == x + 1 or nx == x)
                and (ny == y - 1 or ny == y + 1 or ny == y)
            )
        if M >= 2:
            nx, ny = map(int, input().strip().split())
            n2 = (
                (nx != x or ny != y)
                and (nx == x - 1 or nx == x + 1 or nx == x)
                and (ny == y - 1 or ny == y + 1 or ny == y)
            )
        if M >= 3:
            nx, ny = map(int, input().strip().split())
            n3 = (
                (nx != x or ny != y)
                and (nx == x - 1 or nx == x + 1 or nx == x)
                and (ny == y - 1 or ny == y + 1 or ny == y)
            )
        if M >= 4:
            nx, ny = map(int, input().strip().split())
            n4 = (
                (nx != x or ny != y)
                and (nx == x - 1 or nx == x + 1 or nx == x)
                and (ny == y - 1 or ny == y + 1 or ny == y)
            )
        if M >= 5:
            nx, ny = map(int, input().strip().split())
            n5 = (
                (nx != x or ny != y)
                and (nx == x - 1 or nx == x + 1 or nx == x)
                and (ny == y - 1 or ny == y + 1 or ny == y)
            )
        if M >= 6:
            nx, ny = map(int, input().strip().split())
            n6 = (
                (nx != x or ny != y)
                and (nx == x - 1 or nx == x + 1 or nx == x)
                and (ny == y - 1 or ny == y + 1 or ny == y)
            )
        if M >= 7:
            nx, ny = map(int, input().strip().split())
            n7 = (
                (nx != x or ny != y)
                and (nx == x - 1 or nx == x + 1 or nx == x)
                and (ny == y - 1 or ny == y + 1 or ny == y)
            )
        if M >= 8:
            nx, ny = map(int, input().strip().split())
            n8 = (
                (nx != x or ny != y)
                and (nx == x - 1 or nx == x + 1 or nx == x)
                and (ny == y - 1 or ny == y + 1 or ny == y)
            )
    elif 0 < x < X - 1 or 0 < y < Y - 1:
        if M >= 1:
            nx, ny = map(int, input().strip().split())
            n1 = (
                (nx != x or ny != y)
                and (nx == x - 1 or nx == x + 1 or nx == x)
                and (ny == y - 1 or ny == y + 1 or ny == y)
            )
        if M >= 2:
            nx, ny = map(int, input().strip().split())
            n2 = (
                (nx != x or ny != y)
                and (nx == x - 1 or nx == x + 1 or nx == x)
                and (ny == y - 1 or ny == y + 1 or ny == y)
            )
        if M >= 3:
            nx, ny = map(int, input().strip().split())
            n3 = (
                (nx != x or ny != y)
                and (nx == x - 1 or nx == x + 1 or nx == x)
                and (ny == y - 1 or ny == y + 1 or ny == y)
            )
        if M >= 4:
            nx, ny = map(int, input().strip().split())
            n4 = (
                (nx != x or ny != y)
                and (nx == x - 1 or nx == x + 1 or nx == x)
                and (ny == y - 1 or ny == y + 1 or ny == y)
            )
        if M >= 5:
            nx, ny = map(int, input().strip().split())
            n5 = (
                (nx != x or ny != y)
                and (nx == x - 1 or nx == x + 1 or nx == x)
                and (ny == y - 1 or ny == y + 1 or ny == y)
            )
        n6, n7, n8 = [True] * 3
    else:
        if M >= 1:
            nx, ny = map(int, input().strip().split())
            n1 = (
                (nx != x or ny != y)
                and (nx == x - 1 or nx == x + 1 or nx == x)
                and (ny == y - 1 or ny == y + 1 or ny == y)
            )
        if M >= 2:
            nx, ny = map(int, input().strip().split())
            n2 = (
                (nx != x or ny != y)
                and (nx == x - 1 or nx == x + 1 or nx == x)
                and (ny == y - 1 or ny == y + 1 or ny == y)
            )
        if M >= 3:
            nx, ny = map(int, input().strip().split())
            n3 = (
                (nx != x or ny != y)
                and (nx == x - 1 or nx == x + 1 or nx == x)
                and (ny == y - 1 or ny == y + 1 or ny == y)
            )
        n4, n5, n6, n7, n8 = [True] * 5

if M < 1:
    print("Senshi makannya besok aja deh.")
elif not (n1 and n2 and n3 and n4 and n5 and n6 and n7 and n8):
    print("Senshi makan hari ini!")
else:
    print("Senshi makannya besok aja deh.")
