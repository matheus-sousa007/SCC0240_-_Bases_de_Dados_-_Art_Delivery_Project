import psycopg2 as psy
from datetime import datetime
from flask import Flask

class database():
    def __init__(self):
        self.DB_NAME = 'art-delivery'
        self.DB_USER = 'postgres'
        self.DB_PASS = 'admin'
        self.DB_HOST = 'localhost'
        self.DB_PORT = 5432

    def connection(self):
        self.conn = psy.connect(dbname=self.DB_NAME, user=self.DB_USER, password=self.DB_PASS, host=self.DB_HOST, port=self.DB_PORT)
        self.cursor = self.conn.cursor()

    def close_connection(self):
        self.conn.commit()
        self.conn.close()

    def create_schema(self):
        self.connection()
        file_drop = open("bd/drops.sql", "r").read()
        schema_file = open("bd/esquemas.sql", "r").read()

        self.cursor.execute(file_drop)
        self.cursor.execute(schema_file)

        self.close_connection()


    def insert_user(self, user_data):
        self.connection()
        insert_user = f"""
        INSERT INTO ClassificacaoUsuario VALUES(
            {user_data['nomeUsuario']},
            {user_data['tipoUsuario']},
            {user_data['senha']},
            {user_data['nome']},
            {user_data['rua']},
            {user_data['numero']},
            {user_data['bairro']},
            {user_data['cidade']},
            {user_data['telefone']},
            {user_data['email']},
            {user_data['dataNasc']},
            current_timestamp,
            'NULL'
        """
        print(insert_user)
        insert_user = f"""
                INSERT INTO ClassificacaoComum(NomeUsuario, TipoComum) 
                    VALUES({user_data['nomeUsuario']}, 'cliente')
                """
        
        self.close_connection()
    def check_user(self, user_data):
        self.connection()

        print(f"DENTRO {user_data['nomeUsuario']}")
        query = f"""
            SELECT * FROM ClassificacaoUsuario WHERE 
                (nomeusuario = '{user_data["nomeUsuario"]}') 
                AND (senha = '{user_data["senha"]}')
            """
        
        self.cursor.execute(query)
        user = self.cursor.fetchall()
        if user == []:
            return None, None
        
        elif user[0][1] == 'admnistrador':
            return user, user[0][1].upper()

        query = f"""
            SELECT * FROM ClassificacaoComum WHERE 
                (nomeusuario = '{user_data["nomeUsuario"]}')
            """
        self.cursor.execute(query)
        classificacao_user = self.cursor.fetchall()
        
        self.close_connection()

        return user, classificacao_user[0][1].upper()
        #data_response =
    def add_dados(self):
        file_add = open("bd/dados.sql", "r").read()
        self.connection()
        self.cursor.execute(file_add)

        self.close_connection()

    def more_reaction_album(self, react):
        query = """SELECT * 
                    FROM reage 
                    WHERE post = (SELECT MAX(post) FROM REAGE)
                    SELECT
                    """
        
        self.connection()
        self.cursor.execute(query)
        post = self.cursor.fetchall()

        return post

    def get_users(self):

        self.connection()
        self.cursor.execute("SELECT nomeUsuario FROM classificacaoComum")
        users = self.cursor.fetchall()
        list_users = []
        for user in users:
            list_users.append((user[0]))
        self.close_connection()
        return list_users
    


    def get_followers_of_user(self, user):
        
        self.connection()
        self.cursor.execute(f"SELECT usuariosegue FROM {user}")
        followers = self.cursor.fetchall()
        
        self.close_connection()
        return followers
    
    def get_tags(self):
        self.connection()
        self.cursor.execute("SELECT nome FROM tag")
        tags = self.cursor.fetchall()
        list_tags = []
        for tag in tags:
            list_tags.append((tag[0]))
        self.close_connection()
        return list_tags
    
    def get_post_by_tag(self, tags):
        self.connection()
        query_tags = ''
        for tag in tags:
            query_tags += f"nome='{tag}' OR "
        query_tags = query_tags[:len(query_tags)-3]      # removendo ultimo OR
        print()
        query = f"""
        SELECT P.id as post
                FROM (Post P 
                    JOIN ClassificacaoPost CP
                    ON P.id = CP.post)
                    JOIN (SELECT nome, Count(*) AS nroTagsProcuradas
                            FROM Tag
                            WHERE {query_tags}
                            GROUP BY nome) S
                    ON S.nome = CP.tag
                GROUP BY p.id, S.nroTagsProcuradas
            HAVING Count(*) = S.nroTagsProcuradas
        """
        self.cursor.execute(query)
        posts = self.cursor.fetchall()
        print(posts)

        self.close_connection()

        return posts

        
def create_tables(cursor, schema_file):
    file_drop = open("bd/drops.sql", "r").read()
    file_add = open("bd/dados copy.sql", "r").read()
    cursor.execute(file_drop)
    cursor.execute(schema_file)
    cursor.execute(file_add)
    return


app_flask = Flask(__name__)
app_flask.config['SECRET_KEY'] = "ART_DELIVERY"
import routes