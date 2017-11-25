

After do |scenario| #executa após cada cenário

    if scenario.failed? # se ele falhar
        puts "Request => #{@request.to_json}" #vai exibir no terminal o request
        puts "Código => #{@status}" #o código
        puts "Result => #{@result.parsed_response.to_json}" #e a mensagem recebida no response
        
    end
end