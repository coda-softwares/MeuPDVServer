import dbmanager as dbm
import json as JSON
# import hmac

# VEJA REST_SCHEME.md

# Encoder de json, para retornar para o usuário
json = JSON.JSONEncoder()

# Registrar usuário pela utilização de procedures
def register(req):
    params = {}

    try:
        params = req.json # convert a entrada do body para json
    except Exception as e:
        return req.Response(text=json.encode({'status':'REGISTER_FAILED'}))

    nome = params['nome']
    username = params['username']
    password = params['password']
    id_contato = params['id_contato']

    data = {'status': 'REGISTER_AND_AUTOLOGIN_FAILED'}
    with dbm.Connection() as con:
        re = con.execute(dbm.REGISTER, [password, username, nome, id_contato])
        rel = con.execute(dbm.LOGIN, [username, password])
        if len(rel)==0:
            data['status'] = 'REGISTER_AND_AUTOLOGIN_SUCCESSFUL'
        else:
            data['response_from_db'] = str(re)

    return req.Response(text=json.encode(data), mime_type='json')


# Recebe logins do usuário
def login(req):
    params = {}

    try:
        params = req.json # convert a entrada do body para json
    except Exception as e:
        print(str(e))
        return req.Response(text='Invalid Body')

    # Dados de retorno
    data = {
        'status': 'LOGIN_SUCCESSFUL'
    }
    # Connect to the database
    with dbm.Connection() as con:
        # Retrieve 0 if no login found
        re = con.execute(dbm.LOGIN, [params['username'], params['password']])
        if len(re)==0:
            data['status'] = 'LOGIN_FAILED'

    return req.Response(text=json.encode(data), mime_type='json')

# Recebe logouts do usuário
def logout(req):
    return req.Response(text='Not implemented yet')

# Lista valores dentro de determinas tabelas (veja REST_SCHEME.md '/show')
def show(req):
    params = {}

    try:
        params = req.json # convert a entrada do body para json
    except Exception as e:
        print(str(e))
        return req.Response(text='Invalid Body')

    # META part where we identify what table to show
    table_name = params['table_name']

    # Get the data from the database
    data = {'res':None}
    with dbm.Connection() as con:
        data['res'] = con.execute( dbm.select_from(table_name) )

    return req.Response(text=json.encode(data), mime_type='json')

def delete(req):
    params = {}

    try:
        params = req.json # convert a entrada do body para json
    except Exception as e:
        print(str(e))
        return req.Response(text='Invalid Body')

    table_name = params['table_name']
    where = params['where']
    equals = params['equals']


    data = {'status': 'DELETE_IN_DEV'}
    with dbm.Connection() as con:
        con.execute(dbm.delete_from(table_name), [where, equals])

    return req.Response(text=json.encode(data))
