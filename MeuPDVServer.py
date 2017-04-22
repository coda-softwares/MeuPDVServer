from japronto import Application
# import dbmanager as dbm
import json as JSON

loged = []

def login(req):
    # Estrutura do login
    # Utilizando HMAC
    json = JSON.JSONEncoder()
    data = {
        'corpo': req.json
    }
    return req.Response(text=json.encode(data), mime_type='json')
    # text = str(dir(req))+"--\nform: \n"+str(req.form)+"--\nfiles: "+str(req.files)s
    # res = req.Response(text=text)
    # return res


def logout(req):
    return req.Response(text)

app = Application()
app.router.add_route('/login', login)
app.router.add_route('/logout', logout)
app.run(debug=True, port=80)
