# https://datalemur.com/questions/python-gift-card-satisfaction
def max_satisfaction(expectations, cards):
  expectations = sorted(expectations)
  cards = sorted(cards)
  print(expectations)
  print(cards)
  ans = 0
  i = j = 0
  while i < len(expectations) and j < len(cards):
    if expectations[i] <= cards[j]:
      ans += 1
      i += 1
      j + 1
    else:
      j += 1
  return ans
