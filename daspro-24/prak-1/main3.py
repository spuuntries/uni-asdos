X, Y = map(int, input().split())
x, y = map(int, input().split())
M = int(input())
monsters = [list(map(int, input().strip().split())) for m in range(M)]

if M == 0:
    print("Senshi makannya besok aja deh.")
else:
    directions = [(-1, -1), (0, -1), (1, -1), (-1, 0), (1, 0), (-1, 1), (0, 1), (1, 1)]
    yes = False
    for dx, dy in directions:
        nx, ny = x + dx, y + dy
        if 0 <= nx < X and 0 <= ny < Y and (nx, ny) not in monsters:
            yes = True
            break
    if yes:
        print("Senshi makan hari ini!")
    else:
        print("Senshi makannya besok aja deh.")
