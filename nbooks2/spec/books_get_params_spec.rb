describe('GET /api/books') do
  before(:all) do
    @user = {
      name: 'Juliana Souza',
      email: 'julianasouza@gmail.com',
      password: 'az123456',
    }

    Books.delete("/api/accounts/#{@user[:email]}")

    Books.post(
      '/api/accounts',
      body: @user.to_json,
    )

    @token = get_token(@user)
  end

  describe('Status 200') do
    before(:all) do
      books.each do |book|
        Books.post(
          '/api/books',
          body: book.to_json,
          headers: {'ACCESS_TOKEN' => @token},
        )
      end
    end

    it('buscar por título do livro') do
      @params = {
        title: 'Steve Jobs',
      }
      @result = Books.get(
        "/api/books",
        query: @params,
        headers: {'ACCESS_TOKEN' => @token},
      )

      expect(
        @result.response.code
      ).to eql '200'
      expect(
        @result.parsed_response.size
      ).to eql 1
    end
    it('pesquisa não retorna registro') do
      @params = {
        author: 'Clarice Lins Pector :D ',
      }
      @result = Books.get(
        "/api/books",
        query: @params,
        headers: {'ACCESS_TOKEN' => @token},
      )

      expect(
        @result.response.code
      ).to eql '200'
      expect(
        @result.parsed_response
      ).to be_empty
    end
  end
  after(:each) do |example|
    if example.exception
      puts @token
      puts @result.parsed_response
    end
  end
end
