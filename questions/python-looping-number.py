# https://datalemur.com/questions/python-looping-number
def is_looping(n):
    visited = set()
    steps = 0

    def check(n):
        nonlocal steps
        if n == 1 or steps > 500:
            return False
        if n in visited:
            return True
        visited.add(n)
        sum = 0
        while n:
            digit = n % 10
            sum += digit ** 2
            n //= 10
        steps += 1
        return check(sum)

    return check(n)
