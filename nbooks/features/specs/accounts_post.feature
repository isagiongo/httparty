            #language:pt

Funcionalidade: Cadastro de usuário

@smoke
Cenário: Novo usuário
Dado que o cliente informou seus dados cadastrais
            | name     | Joana de Souza  |
            | email    | joana@gmail.com |
            | password | 123456          |
            Quando faço uma requisição POST para o serviço accounts
            Então o código de resposta deve ser "200"

@duplicado
Cenário: Não permite email duplicado
            Dado que o cliente informou seus dados cadastrais
            | name     | Joana Duplicada  |
            | email    | joana2@gmail.com |
            | password | 123456           |
            Mas esse cliente já está cadastrado
            Quando faço uma requisição POST para o serviço accounts
            Então o código de resposta deve ser "409"
            E deve ser exibido um JSON com a mensagem
            """
            O e-mail informado, ja está cadastrado!
            """
@esquema
Esquema do Cenário: Obrigatoriedade dos Campos
            Dado que o cliente informou seus dados cadastrais
            | name     | <nome>     |
            | email    | <email>    |
            | password | <password> |
            Quando faço uma requisição POST para o serviço accounts
            Então o código de resposta deve ser "409"
            E deve ser exibido um JSON com a mensagem
            """
            <mensagem>
            """
            Exemplos:
            | nome            | email            | password | mensagem                    |
            |                 | joana2@gmail.com | 123456   | Nome deve ser obrigatório!  |
            | Joana Duplicada |                  | 123456   | Email deve ser obrigatório! |
            | Joana Duplicada | joana2@gmail.com |          | Senha deve ser obrigatório! |
