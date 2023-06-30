import psycopg2 as psy
from datetime import datetime


DB_NAME = 'art-delivery'
DB_USER = 'postgres'
DB_PASS = 'admin'
DB_HOST = 'localhost'
DB_PORT = 5432

def create_tables(cursor, schema_file):
    file_drop = open("../bd/drops.sql", "r").read()
    cursor.execute(file_drop)
    cursor.execute(schema_file)
    return

def main():
    if __name__ == '__main__':
        try:
                        
            conn = psy.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST, port=DB_PORT)
            cursor = conn.cursor()
            schema_file = open("../bd/schema.sql", "r").read()
            create_tables(cursor, schema_file)
            print('Sucesso')
        except psy.Error as err:
            print(err)
            pass

    conn.commit()
    conn.close()

main()