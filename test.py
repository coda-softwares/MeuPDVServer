from japronto import Application


def hello(req):
    return req.Response(text=str(req.query))

app = Application()

app.router.add_route('/', hello)
app.run(debug=True, port=8080)
