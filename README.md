[![Code Climate](https://codeclimate.com/github/v-tsvid/ur_secured/badges/gpa.svg)](https://codeclimate.com/github/v-tsvid/ur_secured)


#UR_SECURED
**This service is a super powerful ultimate solution for your web-serfing security. So you're secured now!**

To use UR_SECURED set up your browser plug-in to make correct http-requests. See some request examples powered by curl.

##Request examples



###1. Set up connection with UR_SECURED

First you should set up connection with the service. At the moment URI is `http://localhost:9292` instead of one with the real domain. We can only hope this situation will change one day.



###2. Get unique key

To use UR_SECURED you should request your unique key passing your client metrics (browser name)

__ * URL __

`/api/get_token`

or the RESTful one

`/api/api_clients/`

* ** Method **
`POST`

* ** Data params **

```
  {
    metric : {
      browser : [string]
    }
  }
```

* ** Success response **

Code: 201

Content: `{ token: [string] }`

* ** Error response **

Code: 422

Content: `{ errors: 'Some validation errors' }`

* ** cURL example **

`curl -F "metric[browser]=Firefox" http://localhost:9292/api/get_token`



###3. Update expired key

Your unique key may become expired so you should update it (request the brand new key)

* ** URL **

`/api/update_expired_token/:id`

or the RESTful one

`/api/api_clients/:id`

* ** Method **
`PUT`

* ** URL params **

Required: `id : [string]` 

`id` is your old expired key

* ** Success response **

Code: 200

Content: `{ token: [string] }`

* ** Error response **

Code: 422

Content: `{ errors: 'Some errors' }`

* ** cURL example **

`curl -X PUT http://localhost:9292/api/update_expired_token/a8704ccdb5f0be9fc98684a3d11e5897`



###4. Show client statistics

You can see your statistics like your visited URLs, number of safe and danger URLs you've visited

* ** URL **

`/api/client_stats/:id`

or the RESTful one

`/api/api_clients/:id`

* ** Method **
`GET`

* ** URL params **

Required: `id : [string]` 

`id` is your unique key

* ** Success response **

Code: 200

Content: 

```
{ 
  urls:         [array], 
  safe_count:   [integer],
  unsafe_count: [integer] 
}
```

* ** cURL example **

`curl -X GET http://localhost:9292/api/clients_stats/a8704ccdb5f0be9fc98684a3d11e5897e`



###5. Analyze your webpage

You can analyze the source code of your web-page (including javascript code) and find out if the web-page has malicious scripts or not

* ** URL **

`/api/analyze_content/:id`

* ** Method **
`POST`

* ** URL params **

Required: `id : [string]` 

`id` is your unique key

* ** Data params **

```
  {
    html :         [string],
    javascripts[]: [string],
    ...
    javascripts[]: [string],
    url:           [string]
  }
```

* ** Success response **

Code: 200

Content: `{ answer: [boolean] }`

* ** Error response **

Code: 422

Content: `{ errors: 'Some errors' }`

* ** cURL example **

`curl -F "html=XXX&javascripts[]=YYY&javascripts[]=ZZZ&url=www.example.url" http://localhost:9292/api/analyze_code`

* ** IMPORTANT **
You have to set up your client app to send the source code compressed via Zlib and encoded via Base64. That manipulations are necessary to save your internet traffic. For example in Ruby the code needed to prepare the web-page source code to sending may look like following: 

```
require 'zlib'
require 'base64'

code = "XXX"
compressed = Zlib::Deflate.deflate(code)
code_to_send = Base64.encode64(compressed)
```