from app import app_flask
from app import database
from flask import render_template, request, flash, redirect, url_for

from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField, EmailField, IntegerField, DateField, RadioField, SelectMultipleField, SelectField
from wtforms.validators import DataRequired
import psycopg2 as psy 

db = database()

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

class tagsForm(FlaskForm):
    tags = SelectMultipleField("Tipo de usuario", choices=[])
    submit = SubmitField("Selecionar")

class usersForm(FlaskForm):
    users = SelectField("Nome do usuario", choices=[])
    submit = SubmitField("Selecionar")

class moreReacts(FlaskForm):
    reaction = RadioField("Tipo de reação", choices=[('Like'),('Dislike'), ('Choro'), ('Amei')])
    submit = SubmitField("Selecionar")
    
class minFollower(FlaskForm):
    minFollower = IntegerField("Minimo de Seguidores")
    submit = SubmitField("Selecionar")

    
@app_flask.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        if('reset-db' in request.form):
            db.create_schema()
        if('add-db' in request.form):
            db.add_dados()

    return render_template("index.html")

@app_flask.route('/register', methods=['GET', 'POST'])
def register():

    form = RegisterForm(request.form)
    if request.method == 'POST':
        db.insert_user(form.data)
        return render_template("index.html", form = form)

    return render_template("register.html", form = form)

@app_flask.route('/artista')
def artista():
    return "artista"

@app_flask.route('/post_tag', methods=['GET', 'POST'])
def post_tag():
    db = database()

    form = tagsForm(request.form)
    form.tags.choices = db.get_tags()

    if request.method == 'POST' and form:
        try:
            posts = db.get_post_by_tag(tuple(form.data['tags']))
            return render_template("post_tag.html", form=form, posts=posts)

        except psy.Error as err:
            print(err)
    
    return render_template("post_tag.html", form=form)

@app_flask.route('/followers_by', methods=['GET', 'POST'])
def followers_by():
    db = database()

    form = usersForm(request.form)
    form.users.choices = db.get_users()

    if request.method == 'POST':
        try:
            
            users = db.get_followers_of_user(form.data['users'])
            return render_template("followers_by.html", form=form, users=users, user_follow=form.data['users'])

        except psy.Error as err:
            print(err)
    return render_template("followers_by.html", form=form)

@app_flask.route('/more_reaction', methods=['GET', 'POST'])
def more_reaction():
    form = moreReacts()

    if request.method == 'POST':
        try:
            db = database()
            post_id, post_artist = db.more_reaction_album(form.data['reaction'])
            return render_template("more_react.html", form=form, id=post_id, artist=post_artist)

        except psy.Error as err:
            print(err)

    return render_template("more_react.html", form=form)

@app_flask.route('/artist_by_min_follower', methods=['GET', 'POST'])
def artist_by_min_follower():
    form = minFollower()

    if request.method == 'POST':
        try:
            db = database()
            artists = db.artist_by_min_follower(form.data['minFollower'])
            return render_template("artist_by_min_follower.html", form=form, artists=artists)

        except psy.Error as err:
            print(err)

    return render_template("artist_by_min_follower.html", form=form)

@app_flask.route('/usuarios_banidos', methods=['GET', 'POST'])
def usuarios_banidos():
    
    db = database()

    form = usersForm(request.form)
    form.users.choices = db.get_users(ehAdmin=True)

    if request.method == 'POST':
        try:
            users = db.usuarios_banidos(form.data['users'])
            #banidos = db.artist_by_min_follower(form.data['minFollower'])
            return render_template("usuarios_banidos.html", form=form, users=users)

        except psy.Error as err:
            print(err)
    return render_template("usuarios_banidos.html", form=form)
