describe('POST /api/books') do
  before(:all) do
    @user = {
      name: 'Luiza',
      email: 'luiza@gmail.com',
      password: 'abc4321',
    }

    Books.delete("/api/accounts/#{@user[:email]}")

    Books.post('/api/accounts', body: @user.to_json)

    @token = get_token(@user)
  end

  describe('status 200') do
    before(:all) do
      @book = {
        title: 'Docker',
        author: 'Rafael Gomes',
        tags: %w[
          Técnico,
          Software
        ],
      }

      Books.post(
        '/api/books',
        body: @book.to_json,
        headers: {'ACCESS_TOKEN' => @token},
      )

      @result = Books.get(
        '/api/books',
        query: {title: @book[:title]},
        headers: {'ACCESS_TOKEN' => @token},
      )
      @book = @result.first
    end

    it('atualiza livro') do
      @change_book = {
        title: 'Docker para Desenvolvedores',
        author: 'Rafael Gomes',
        tags: %w[
          Técnico,
          Software,
          TI,
          DevOps
        ],
      }

      @result = Books.put(
        "/api/books/#{@book['id']}",
        body: @change_book.to_json,
        headers: {'ACCESS_TOKEN' => @token},
      )

      expect(@result.response.code).to eql '200'
      expect(@result.parsed_response).not_to eql @book
    end
  end
  describe('status 404') do
    it('id do livro não existe') do
      @change_book = {
        title: 'Docker para Desenvolvedores',
        author: 'Rafael Gomes',
        tags: %w[
          Técnico,
          Software,
          TI,
          DevOps
        ],
      }
      @result = Books.put(
        "/api/books/#{Faker::Lorem.characters(25)}",
        body: @change_book.to_json,
        headers: {'ACCESS_TOKEN' => @token},
      )

      expect(@result.response.code).to eql '404'
      expect(@result.parsed_response['message']).to eql 'Livro não encontrado.'
    end
  end

  after(:each) do |example|
    puts @result.parsed_response if example.exception
  end
end
