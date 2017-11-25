#encoding:utf-8

Dado("que o cliente informou seus dados cadastrais") do |table| #cenário que cadastra o usuário
  @request = table.rows_hash #armazena na variavel a tabela recebida do cenário de BDD
  remove_account(@request)  #método que remove o usuário, passando a variavel com a tabela recebida do arquivo features
end

Dado("esse cliente já está cadastrado") do #cenário que testa o usuário duplicado
  steps %(Quando faço uma requisição POST para o serviço accounts  
    ) # aproveita o step do cenário abaixo para cadastrar um cliente e este ficar duplicado ao executar o Quando
end

Quando("faço uma requisição POST para o serviço accounts") do
  @result = HTTParty.post( # armazena na variável result o que foi enviado via POST
    'http://nbooks.herokuapp.com/api/accounts',
    body: @request.to_json, # e passa no body da requisição a tabela que está sendo passada pelo BDD com os dados do cliente
  )
end

Então("o código de resposta deve ser {string}") do |status_code|
  @status = status_code  #armazena na variavel status o código que está sendo recebido da resposta
  expect(@result.response.code).to eql status_code #compara o recebido pelo response e o que é esperado no BDD
end

Então("deve ser exibido um JSON com a mensagem") do |message|
  expect(@result.parsed_response['message']).to eql message #compara a mensagem recebida com a esperada pelo BDD
end
