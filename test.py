import dbmanager as dbm


# DECLARA PARA FUTUTO USO
SELECT_FORNECEDOR = """
SELECT * FROM Fornecedor
WHERE nome_Forn=%s
"""

# Instancia uma nova conexão dentro deste bloco de codigo
with dbm.Connection() as con:
    injection = "Jefferson"#SELECT * FROM Fornecedor"
    res = con.execute(SELECT_FORNECEDOR, [injection])
    for r in res:
        print("\nRESPONSE: "+str(r))

    # Quando o bloco de codigo termina, ele fecha a conexão
