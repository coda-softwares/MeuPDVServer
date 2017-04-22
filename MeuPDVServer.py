from japronto import Application
import dbmanager as dbm
import json as JSON

loged = []

def login(req):
    # Estrutura do login
    # Utilizando HMAC
    text = req.body
    res = req.Response(text=text, mime_type='text/plain')
    return res


def logout(req):
    return req.Response(text)

app = Application()
app.router.add_route('/login', login)
app.router.add_route('/logout', logout)
app.run(debug=True, port=8080)
