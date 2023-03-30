require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  # context "GET /albums" do
  #   xit 'should return a list of albums' do
  #   response = get("/albums")

  #   # expect(response.status).to eq(200)
  #   expect(response.body).to eq('Surfer Rosa,Waterloo,Super Trouper,Bossanova,Lover,Folklore,I Put a Spell on You,Baltimore,Here Comes the Sun,Fodder on My Wings,Ring Ring')
  #   end

    

  #   xit 'returns 404 Not Found' do
  #     response = get('/posts?id=276278')

  #     expect(response.status).to eq(404)
  #     # expect(response.body).to eq(expected_response)
  #   end

  #   context 'it adds an album to the database' do
  #     xit 'returns 200 and adds an album' do
  #       response = post('/albums', title: 'Voyage', release_year:'2022', artist_id:2)
  #       expect(response.status).to eq(200)
        
  #     end
  #   end

  #   xit 'should return a list of albums' do
  #     post_attempt = post('/albums', title: 'Voyage', release_year:'2022', artist_id:2)
  #     response = get("/albums")
  
  #     expect(response.status).to eq(200)
  #     expect(response.body).to eq('Surfer Rosa,Waterloo,Super Trouper,Bossanova,Lover,Folklore,I Put a Spell on You,Baltimore,Here Comes the Sun,Fodder on My Wings,Ring Ring,Voyage')
  #     end
  
  #   context "GET /artists" do
  #     xit 'should return a list of artists' do
  #     response = get("/artists")
  
  #     expect(response.status).to eq(200)
  #     expect(response.body).to eq('Pixies,ABBA,Taylor Swift,Nina Simone,Kiasmos')
  #     end
  
      
  
  #     xit 'returns 404 Not Found' do
  #       response = get('/posts?id=276278')
  
  #       expect(response.status).to eq(404)
  #       # expect(response.body).to eq(expected_response)
  #     end
  
  #     context 'it adds an artist to the database' do
  #       xit 'returns 200 and adds an artist' do
  #         response = post('/artists', title: 'Voyage', release_year:'2022', artist_id:2)
  #         expect(response.status).to eq(200)
          
  #       end
  #     end
  
  #     xit 'should return a list of artists' do
  #       post_attempt = post('/artists', name: 'Wild nothing', genre:'Indie')
  #       response = get("/artists")
    
  #       expect(response.status).to eq(200)
  #       expect(response.body).to eq('Pixies,ABBA,Taylor Swift,Nina Simone,Kiasmos,Wild nothing')
  #     end
  #   end

    context 'GET /albums/:id' do
      it 'should return info about album 1' do
        response = get('/albums/2')
        expect(response.status).to eq(200)
        expect(response.body).to include('<h1>Surfer Rosa</h1>')
      end
    end

    context 'GET /albums' do
      it 'should contain a list of albums with links' do
        response = get('/albums')
        expect(response.status).to eq(200)
        expect(response.body).to include('<a href="/albums/8">I Put a Spell on You</a>')
        expect(response.body).to include('<a href="/albums/4">Super Trouper</a>')
      end
    end

    context "GET /albums/new" do 
      it "should return the html form to add a new album" do
        response = get('/albums/new')
        
        expect(response.status).to eq(200)
        expect(response.body).to include('<form method="POST" action="/albums">')
        expect(response.body).to include('<input type="text" name="album_name"/>')
      end
    end

    context "POST/albums" do
      it "should create a first album with the given album title from get/albums/new " do
        response = post('/albums', album_name: 'Life is Yours')

        expect(response.status).to eq(200)
        expect(response.body).to include('<h1>Your saved album: Life is Yours</h1>')
      end

      it "should create a second album with the given album title from get/albums/new " do
        response = post('/albums', album_name: 'El Dorado')

        expect(response.status).to eq(200)
        expect(response.body).to include('<h1>Your saved album: El Dorado</h1>')
      end

      # it "return 400 if empty or nil params" do
      #   response = post('/albums', album_name: nil, release_year: 2022, artist_id: nil)
      #   expect(response.status)to eq(400)
      # end

      # it "return 400 if empty or nil params" do
      #   response = post('/albums', album_name: 'La vecina de al lado', release_year: 2022, artist_id: nil)
      #   expect(response.status)to eq(400)
      # end

      # it "return 400 if empty or nil params" do
      #   response = post('/albums', album_name: '', release_year: '', artist_id: '')
      #   expect(response.status)to eq(400)
      # end
    end

    context "GET /artists/new" do 
      it "should return the html form to add a new album" do
        response = get('/artists/new')
        
        expect(response.status).to eq(200)
        expect(response.body).to include('<form method="POST" action="/artists">')
        expect(response.body).to include('<input type="text" name="artist_name"/>')
      end
    end

    context "POST/artists" do
      it "should create a first artist with the given artist name from get/artists/new " do
        response = post('/artists', artist_name: 'Foals')

        expect(response.status).to eq(200)
        expect(response.body).to include('<h1>This is your new artist added: Foals</h1>')
      end

      it "should create a second artist with the given artist name from get/artists/new " do
        response = post('/artists', artist_name: 'Shakira')

        expect(response.status).to eq(200)
        expect(response.body).to include('<h1>This is your new artist added: Shakira</h1>')
      end
    end
end