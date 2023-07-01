from app import app_flask
from app import database
from flask import render_template, request, flash, redirect, url_for

from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, EmailField, IntegerField, DateField, RadioField, SelectMultipleField, SelectField
from wtforms.validators import DataRequired
import psycopg2 as psy 

class RegisterForm(FlaskForm):
    nomeUsuario = StringField("Nome de Usuario", validators=[DataRequired()])
    nome = StringField("Nome", validators=[DataRequired()])
    email = EmailField("Email", validators=[DataRequired()])
    senha = StringField("Senha", validators=[DataRequired()])
    rua = StringField("Rua", validators=[DataRequired()])
    numero = IntegerField("Numero", validators=[DataRequired()])
    bairro = StringField("Bairro", validators=[DataRequired()])
    cidade = StringField("Cidade", validators=[DataRequired()])
    tipoUsuario = RadioField("Tipo de usuario", choices=[('Cliente'),('Artista')])
    dataNasc = DateField("Data de Nascimento", validators=[DataRequired()])
    telefone = StringField("Telefone", validators=[DataRequired()])
    submit = SubmitField("Enviar")

class LoginForm(FlaskForm):
    nomeUsuario = StringField("Nome de Usuario", validators=[DataRequired()])
    senha = StringField("Senha", validators=[DataRequired()])
    submit = SubmitField("Enviar")

def get_tags():
    db = database()
    return db.tags()


class tagsForm(FlaskForm):
    db = database()
    tags = SelectMultipleField("Tipo de usuario", choices=db.get_tags())
    submit = SubmitField("Selecionar")

class usersForm(FlaskForm):
    db = database()
    users = SelectField("Nome do usuario", choices=db.get_users())
    submit = SubmitField("Selecionar")

class moreReacts(FlaskForm):
    reaction = RadioField("Tipo de usuario", choices=[('Like'),('Dislike'), ('Choro'), ('Amei')])
    submit = SubmitField("Selecionar")
    
class minFollower(FlaskForm):
    minFollower = IntegerField("Minimo de Seguidores")
    
@app_flask.route('/', methods=['GET', 'POST'])
def index():
    return render_template("index.html")

@app_flask.route('/register', methods=['GET', 'POST'])
def register():

    form = RegisterForm(request.form)
    if request.method == 'POST':
        insert_user = f"""
                INSERT INTO ClassificacaoComum(NomeUsuario, TipoComum) 
                    VALUES({form.nomeUsuario.data}, 'cliente')
                """
        db = database()
        try:
            db.insert_user(form.data)
        except psy.Error as err:
            print(err)


        return 'OK'

    return render_template("register.html",
                            form = form,
                           )

def get_follows():
    db = database()
    return 0

@app_flask.route('/artista')
def artista():
    return "artista"

@app_flask.route('/post_tag', methods=['GET', 'POST'])
@app_flask.route('/post_tag')
def post_tag():
    form = tagsForm()

    if request.method == 'POST':

        try:
            db = database()
            posts = db.get_post_by_tag(tuple(form.data['tags']))
            return render_template("post_tag.html", form=form, posts=posts)

        except psy.Error as err:
            print(err)

    return render_template("post_tag.html", form=form)

@app_flask.route('/followers_by', methods=['GET', 'POST'])
def followers_by():
    form = usersForm()

    if request.method == 'POST':

        try:
            db = database()
            users = db.get_followers_of_user(tuple(form.data['user']))
            return render_template("followers_by.html", form=form, users=users)

        except psy.Error as err:
            print(err)

    return render_template("followers_by.html", form=form)

@app_flask.route('/more_reaction', methods=['GET', 'POST'])
def more_reaction():
    form = moreReacts()

    if request.method == 'POST':
        try:
            db = database()
            post = db.more_reaction_album(tuple(form.data['reaction']))
            return render_template("more_react.html", form=form, post=post)

        except psy.Error as err:
            print(err)

    return render_template("more_react.html", form=form)

@app_flask.route('/artist_by_min_follower', methods=['GET', 'POST'])
def artist_by_min_follower():
    form = minFollower()

    if request.method == 'POST':
        try:
            db = database()
            artists = db.more_reaction_album(tuple(form.data['reaction']))
            return render_template("artist_by_min_follower.html", form=form, post=artists)

        except psy.Error as err:
            print(err)

    return render_template("artist_by_min_follower.html", form=form)

@app_flask.route('/usuarios_banidos', methods=['GET', 'POST'])
def usuarios_banidos():

    return render_template("artist_by_min_follower.html", form=form)