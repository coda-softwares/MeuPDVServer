import MySQLdb as mariadb
from MySQLdb.cursors import DictCursor

DB='MobPDV'
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
