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
        file_drop = open("bd/drops.sql", "r").read()
        schema_file = open("bd/esquemas.sql", "r").read()
        try:
            self.connection()
            self.cursor.execute(file_drop)
            self.conn.commit()
            self.cursor.execute(schema_file)
            self.close_connection()

        except psy.OperationalError as err:
            print(err)



    def insert_user(self, user_data):
        query1 = f"""
            INSERT INTO ClassificacaoUsuario VALUES(
                '{user_data['nomeUsuario']}',
                'Comum',
                '{user_data['senha']}',
                '{user_data['nome']}',
                '{user_data['rua']}',
                '{user_data['numero']}',
                '{user_data['bairro']}',
                '{user_data['cidade']}',
                '{user_data['telefone']}',
                '{user_data['email']}',
                '{user_data['dataNasc']}',
                current_timestamp,
                'NULL');
            """
        query2 = f"""
                INSERT INTO ClassificacaoComum VALUES(
                '{user_data['nomeUsuario']}',
                '{user_data['tipoUsuario']}'
                );
        """
        
        try:
            self.connection()
            self.cursor.execute(query1)
            self.cursor.execute(query2)
            self.close_connection()
        except psy.OperationalError as err:
            print(err)
            return None



    def add_dados(self):
        try:
            file_add = open("bd/dados.sql", "r").read()
            self.connection()
            self.cursor.execute(file_add)
            self.close_connection()
        except psy.OperationalError as err:
            print(err)

    def more_reaction_album(self, react):

        query = f"""SELECT post, artista
                FROM POST
                WHERE nro{react} = (SELECT MAX(nro{react}) FROM POST);
            """
        try:
            self.connection()
            self.cursor.execute(query)
            post = self.cursor.fetchall()[0]
            post_id = post[0]
            post_artist = post[1]
        
        except psy.OperationalError as err:
            print(err)
            return None, None

        return post_id, post_artist

    def get_users(self):

        try:
            self.connection()
            self.cursor.execute("SELECT nomeUsuario FROM classificacaoUsuario")
            users = self.cursor.fetchall()
            list_users = []
            for user in users:
                list_users.append((user[0]))
            self.close_connection()
            return list_users
        except psy.OperationalError as err:
            print(err)
            return None
    


    def get_followers_of_user(self, user):
        try:
            self.connection()
            self.cursor.execute(f"SELECT usuarioseguido FROM segue AS S WHERE(S.usuariosegue='{user}')")
            followers = self.cursor.fetchall()
            self.close_connection()
            return followers

        except psy.OperationalError as err:
            print(err)
            return None

        
    
    def get_tags(self):
        self.connection()
        try:
            self.cursor.execute("SELECT nome FROM tag")
            tags = self.cursor.fetchall()
            list_tags = []
            for tag in tags:
                list_tags.append((tag[0]))
            self.close_connection()
            return list_tags
        except psy.OperationalError as err:
            print(err)
            return None
       
    def artist_by_min_follower(self, min_follower):
        query = f"""SELECT nomeusuario FROM classificacaoComum AS C 
                    WHERE (C.numseguidores > {min_follower} 
                    and UPPER(C.tipocomum) = 'ARTISTA')"""
        try:
            self.connection()   
            self.cursor.execute(query)
            artists = self.cursor.fetchall()
            list_artists = []
            for artist in artists:
                list_artists.append((artist[0]))
            self.close_connection()
            return list_artists
        except psy.OperationalError as err:
            print(err)
            return None

    def get_post_by_tag(self, tags):
        query_tags = ''
        for tag in tags:
            query_tags += f"nome='{tag}' OR "
        query_tags = query_tags[:len(query_tags)-3]      # removendo ultimo OR


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
        try:
            self.connection()
            self.cursor.execute(query)
            posts = self.cursor.fetchall()
            self.close_connection()
            return posts
        except psy.OperationalError as err:
            print(err)
            return None


app_flask = Flask(__name__)
app_flask.config['SECRET_KEY'] = "ART_DELIVERY"
import routes