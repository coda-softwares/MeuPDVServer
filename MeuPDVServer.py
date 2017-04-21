from japronto import Application

def hello(req):
    return req.Response(text="Hello World")


app = Application()

app.router.add_route("/", hello)
app.run(debug=True, port=2017)
