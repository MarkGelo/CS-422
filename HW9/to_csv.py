
import pandas as pd

def check_int(text):
    try:
        t = int(text)
        return True
    except:
        return False

with open('file19.txt', 'r') as f:
    lines = f.readlines()
    row = 0
    col = 0
    title = ""
    columns = []
    data = {}
    full_data = []
    for line in lines:
        line = line.replace('\n', '')
        if line.startswith('#'):
            continue
        if not title:
            title = line
            continue
        elif not row:
            row = line
            continue
        elif not col:
            col = line
            continue
        elif not columns:
            cols = line.replace('"', '')
            cols = cols.split(' ')
            while '' in cols:
                cols.remove('')
            columns = cols
            continue
        dat = line.replace('"', '')
        for i, c in enumerate(dat):
            if c.isdigit():
                idx = i
                break
        datt = [' '.join(dat[:idx].split(' ')).strip()]
        dat = dat[idx:]
        dat = dat.split(' ')
        dat = [int(x) for x in dat]
        datt.extend(dat)
        
        for x in range(len(columns)):
            data[columns[x]] = datt[x]
        full_data.append(data)
        data = {}

with open('file19-cleaned.txt', 'w') as f:
    f.write(','.join(columns) + '\n')
    for line in full_data:
        f.write(','.join(str(x) for x in line.values()) + '\n')

read_file = pd.read_csv('file19-cleaned.txt')
read_file.to_csv('file19.csv')
