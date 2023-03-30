# {{ METHOD }} {{ PATH}} Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

```
# Request:
Get /artists

#expected resonse (200 ok)
Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing

POST /artists

# With body parameters:
name = Wild nothing
genre = Indie
# Expected response (200 OK)
(No content)


```
## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```html
<!-- EXAMPLE -->
<!-- Response when the post is found: 200 OK -->
POST
(no content)
```

```html
<!-- EXAMPLE -->
<!-- Response when the post is not found: 404 Not Found -->
(no content)

```

<!-- EXAMPLE -->
<!-- Response when the post is found: 200 OK -->
GET
Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing
```

```html
<!-- EXAMPLE -->
<!-- Response when the post is not found: 404 Not Found -->
(no content)

```
## 3. Write Examples

_Replace these with your own design._

```
# Request:

POST /artists

With body parameters:
name = Wild nothing
genre = Indie

# Expected response:
(no response)
Response for 200 OK
```

```
# Request:

GET /artists

# Expected response:

All artists (included new one)

```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

context "GET /artists" do
    it 'should return a list of artists' do
    response = get("/artists")

    expect(response.status).to eq(200)
    expect(response.body).to eq('Pixies, ABBA, Taylor Swift, Nina Simone')
    end

    

    it 'returns 404 Not Found' do
      response = get('/posts?id=276278')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end

    context 'it adds an artist to the database' do
      it 'returns 200 and adds an artist' do
        response = post('/artists', title: 'Voyage', release_year:'2022', artist_id:2)
        expect(response.status).to eq(200)
        
      end
    end

    it 'should return a list of artists' do
      post_attempt = post('/artists', name: 'Wild nothing', genre:'Indie')
      response = get("/artists")
  
      expect(response.status).to eq(200)
      expect(response.body).to eq('Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing')
      end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fweb-applications&prefill_File=resources%2Fsinatra_route_design_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->