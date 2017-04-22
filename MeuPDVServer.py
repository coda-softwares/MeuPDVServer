import dbmanager as dbm
import json as JSON
# import hmac

# Encoder de json, para retornar para o usuário
json = JSON.JSONEncoder()

# Recebe logins do usuário
def login(req):
    params = {}

    try:
        params = req.json # convert a entrada do body para json
    except Exception as e:
        print(str(e))

    # Dados de retorno
    data = {
        'status': 'LOGIN_SUCCESSFUL'
    }
    # Connect to the database
    with dbm.Connection() as con:
        # Retrieve 0 if no login found
        re = con.execute(dbm.LOGIN, [params['username'], params['passwd']])
        if len(re)==0:
            data['status'] = 'LOGIN_FAILED'

    return req.Response(text=json.encode(data), mime_type='json')

# Recebe logouts do usuário
def logout(req):
    return req.Response(text='Not implemented yet')


def show(req):
    params = {}

    try:
        params = req.json # convert a entrada do body para json
    except Exception as e:
        print(str(e))

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
        params = req.json
    except Exception as e:
        print(str(e))
        return req.Response(text='Invalid Body')

    table_name = params['table_name']
    where = params['where']
    equals = params['equals']

    with dbm.Connection() as con:
        con.execute(dbm.delete_from(table_name), [where, equals])

# Registrar usuário pela utilização de procedures
def register(req):
    params = {}

    try:
        params = req.json
    except Exception as e:
        return req.Response(text=json.encode({'status':'REGISTER_FAILED'}))

    nome = paramas['nome']
    username = params['username']
    password = params['password']

    data = {'res':None}
    with dbm.Connection() as con:
        con.execute(dbm.REGISTER, [nome, userame, password])
        data['res'] = con.execute(dbm.REGISTER, [username, password])

    return req.Response(text=json.encode(data), mime_type='json')
