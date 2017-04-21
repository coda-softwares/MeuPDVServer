from japronto import Application
import dbmanager as dbm

def login(req):
    # Estrutura do login
    # Utilizando HMAC
    params = req.query

def logout(req):
    pass

app = Application()

app.run(debug=True, port=2017)
