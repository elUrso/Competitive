def riddle(arr):
    stack = []
    # find max length of left window
    left = {}
    n = len(arr)
    for i in range(n):
        if len(stack) == 0:
            stack.append(i)
        else: 
            while len(stack) > 0 and arr[stack[-1]] > arr[i]:
                topIndex = stack.pop()
                left[topIndex] = i - topIndex
            stack.append(i)

    # empty stack of left window
    while len(stack) > 0:
        topIndex = stack.pop()
        left[topIndex] = n - topIndex
    
    # find max length of right window
    right = {}
    offset = n - 1
    for i in range(n):
        if len(stack) == 0:
            stack.append(i)
        else: 
            while len(stack) > 0 and arr[offset - stack[-1]] > arr[offset - i]:
                topIndex = stack.pop()
                right[offset - topIndex] = i - topIndex
            stack.append(i)
    
    # empty stack of right window
    while len(stack) > 0:
        topIndex = stack.pop()
        right[offset - topIndex] = n - topIndex
    
    # combine results
    combine = {}
    for i in range(n):
        combine[i] = left[i] + right[i] - 1
    
    # map inverse keeping maximum
    inverse = {}
    for i in range(n):
        if combine[i] in inverse:
            value = inverse[combine[i]]
            if arr[i] > value:
                inverse[combine[i]] = arr[i]
        else:
            inverse[combine[i]] = arr[i]
    
    tempMax = 0
    reversedAnswer = []
    for j in range(n):
        i = n - j
        if i in inverse:
            value = inverse[i]
            reversedAnswer.append(value)
            tempMax = value
        else:
            reversedAnswer.append(tempMax)
    return reversedAnswer[::-1]

print(riddle([11, 2, 3, 14, 5, 2, 11, 12]))