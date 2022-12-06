def check_number(number):
    doubles = False
    decrease = False
    repeat = 0

    num = [int(x) for x in str(number)]

    for i in range(5):
        if num[i] == num[i + 1]:
            repeat += 1
        else:
            if repeat == 1:
                doubles = True
            
            repeat = 0
        
        if num[i] > num[i + 1]:
            decrease = True

    if repeat == 1:
        doubles = True
    
    if not decrease and doubles:
        return True
    else:
        return False
        

if __name__ == "__main__":
    bottom = 147981
    top = 691423

    count = 0

    for i in range(147981, 691423, 1):
        if check_number(i):
            count += 1

    print(count)