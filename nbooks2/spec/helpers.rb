module Helpers
  def get_token(user)
    result = Books.post(
      '/api/token',
      body: {
        email: user[:email],
        password: user[:password],
      }.to_json,
    )
    return result.parsed_response['account_token']
  end

  def books
    [
      {
        title: 'Pequeno Príncipe',
        author: 'Saint-Exupery',
        tags: ['Ficção', 'Literatura'],
      },
      {
        title: 'Steve Jobs',
        author: 'Walter Isaacson',
        tags: ['Biografia', 'Literatura'],
      },
      {
        title: 'As Receitas',
        author: 'Bela Gil',
        tags: ['Gastronomia', 'Não-Ficção'],
      },
    ]
  end
end
