import MySQLdb as mariadb
from MySQLdb.cursors import DictCursor

DB='MeuPDV'
USER = 'mpdv'
PASSWORD = 'ab0cfde2c1'

class Connection:
    def __enter__(self):
        self.con = mariadb.connect(user=USER, passwd=PASSWORD, db=DB)
        return self

    def execute(self, string, params=[]):
        c = self.con.cursor(DictCursor)

        final = []

        for line in range(c.execute(string,params)):
            final.append(c.fetchone())

        return final

    def __exit__(self, type, value, traceback):
        self.con.close()

REGISTER = "CALL Register(%s, %s, %s)"
LOGIN = "CALL Login(%s, %s)"

# ! Use only to append the table name !
def select_from(table):
    return "SELECT * FROM "+table

def delete_from(table):
    return "DELETE FROM "+table+" WHERE %s=%s"
