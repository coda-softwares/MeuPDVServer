from japronto import Application as App
import MeuPDVServer as server

app = App()
router = app.router

# router.add_route('/', server.admin_page)
router.add_route('/login', server.login) # needs `username` and `password`
router.add_route('/logout', server.logout)
router.add_route('/show', server.show) # needs `table_name`
