

products = {}
with open('products.csv', 'r') as f:
    for row in f:
        row = row.replace('\n', '').split(',')
        row = [x.strip() for x in row]
        products[row[0]] = row[1]

with open('tr-75k-canonical.csv', 'w') as f_w:
    with open('tr-75k.csv', 'r') as f:
        for row in f:
            row = row.replace('\n', '').split(',')
            row = [x.strip() for x in row]
            # dont care about index 0 - just unique id
            row = row[1:]
            #print(', '.join([products[x] for x in row]))
            line = ', '.join([products[x] for x in row])
            line += '\n'
            f_w.write(line)