def printError(code, error):
    with open('index.html','r') as file:
        s = file.read()
        print(s.format('Error', f'{code}: {error}'))
    exit()