# REST Scheme

O objetivo deste arquivo é informar sobre o mapa de métodos acessíveis e seus parametros por HTTP

Rotas (Routes)
* Logar `POST` `/login`, no `body`:
    * chamada:
    ```json
    {
        "username": "Jefferson",
        "password": "senha"
    }
    ```
    * retorno
    ```json
    {
        "STATUS": "SUCCESSFUL"
    }
    ```
* Registrar novo usuario`POST` `/register`:
    * chamada
    ```json
    {
        "name": "Bianca Da Costa",
        "username": "bicosta",
        "password": "2017",
        "id_contato": 2
    }
    ```
    * retorno
    ```json
    ```

* Teste ver dados de uma tabela `POST` `/show`:
    * chamada
    ```json
    {
        "table_name": "Fornecedor"
    }
    ```
    * retorno
    ```json
    {
        "data": [
            {
                "Contato_id_Contato": 1,
                "id_Forn": 2,
                "nome_Forn": "Jefferson"
            }
        ]
    }
    ```
* Teste deletar dados de uma tabela `POST` `/delete`:
    * chamada
    ```json
    {
        "table_name": "Usuario",
        "where": "username_Usuario",
        "equals": "samosaara"
    }
    ```
    * retorno
    ```json
    ```
