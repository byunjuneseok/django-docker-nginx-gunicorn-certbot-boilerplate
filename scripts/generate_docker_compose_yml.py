import sys

if __name__ == "__main__":
    if len(sys.argv) == 2:
        file_dir = 'docker-compose.yml'
        text_to_replace = 'app.wsgi'
        text_to_insert = str(sys.argv[1]) + '.wsgi'

        s = open(file_dir).read()
        s = s.replace(text_to_replace, text_to_insert)
        f = open(file_dir, 'w')
        f.write(s)
        f.close()
        quit()
    else:
        print("Error occured while generating docker-compose.yml")
        quit()
