module Helpers

    def remove_account(user)  #metodo que remove usuário que vem do bdd baseado no email
        HTTParty.delete("http://nbooks.herokuapp.com/api/accounts/#{user['email']}")
    end
end