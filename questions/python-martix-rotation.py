# https://datalemur.com/questions/python-martix-rotation
def find_rotation(mat, target):
    assert len(mat) == len(target)
    assert len(mat[0]) == len(target[0])
    assert len(mat) == len(mat[0])

    def rotate(a):
        N = len(a)
        for i in range(N // 2):
            for j in range(i, N - 1 - i):
                a[i][j], a[j][N - 1 - i], a[N - 1 - i][N - 1 - j], a[N - 1 - j][i] = (
                    a[j][N - 1 - i], a[N - 1 - i][N - 1 - j], a[N - 1 - j][i], a[i][j]
                )

    for _ in range(3):
        if mat == target:
            return True
        rotate(mat)
    return False
