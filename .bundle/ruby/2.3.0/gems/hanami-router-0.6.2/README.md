# Hanami::Router

Rack compatible, lightweight and fast HTTP Router for Ruby and [Hanami](http://hanamirb.org).

## Status

[![Gem Version](http://img.shields.io/gem/v/hanami-router.svg)](https://badge.fury.io/rb/hanami-router)
[![Build Status](http://img.shields.io/travis/hanami/router/master.svg)](https://travis-ci.org/hanami/router?branch=master)
[![Coverage](http://img.shields.io/coveralls/hanami/router/master.svg)](https://coveralls.io/r/hanami/router)
[![Code Climate](http://img.shields.io/codeclimate/github/hanami/router.svg)](https://codeclimate.com/github/hanami/router)
[![Dependencies](http://img.shields.io/gemnasium/hanami/router.svg)](https://gemnasium.com/hanami/router)
[![Inline docs](http://inch-ci.org/github/hanami/router.png)](http://inch-ci.org/github/hanami/router)

## Contact

* Home page: http://hanamirb.org
* Mailing List: http://hanamirb.org/mailing-list
* API Doc: http://rdoc.info/gems/hanami-router
* Bugs/Issues: https://github.com/hanami/router/issues
* Support: http://stackoverflow.com/questions/tagged/hanami
* Chat: http://chat.hanamirb.org

## Rubies

__Hanami::Router__ supports Ruby (MRI) 2.2+, JRuby 9k+


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hanami-router'
```

And then execute:

```shell
$ bundle
```

Or install it yourself as:

```shell
$ gem install hanami-router
```

## Getting Started

```ruby
require 'hanami/router'

app = Hanami::Router.new do
  get '/', to: ->(env) { [200, {}, ['Welcome to Hanami::Router!']] }
end

Rack::Server.start app: app, Port: 2300
```

## Usage

__Hanami::Router__ is designed to work as a standalone framework or within a
context of a [Hanami](http://hanamirb.org) application.

For the standalone usage, it supports neat features:

### A Beautiful DSL:

```ruby
Hanami::Router.new do
  get '/', to: ->(env) { [200, {}, ['Hi!']] }
  get '/dashboard',   to: Dashboard::Index
  get '/rack-app',    to: RackApp.new
  get '/flowers',     to: 'flowers#index'
  get '/flowers/:id', to: 'flowers#show'

  redirect '/legacy', to: '/'

  mount Api::App, at: '/api'

  namespace 'admin' do
    get '/users', to: Users::Index
  end

  resource 'identity' do
    member do
      get '/avatar'
    end

    collection do
      get '/api_keys'
    end
  end

  resources 'robots' do
    member do
      patch '/activate'
    end

    collection do
      get '/search'
    end
  end
end
```



### Fixed string matching:

```ruby
router = Hanami::Router.new
router.get '/hanami', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
```



### String matching with variables:

```ruby
router = Hanami::Router.new
router.get '/flowers/:id', to: ->(env) { [200, {}, ["Hello from Flower no. #{ env['router.params'][:id] }!"]] }
```



### Variables Constraints:

```ruby
router = Hanami::Router.new
router.get '/flowers/:id', id: /\d+/, to: ->(env) { [200, {}, [":id must be a number!"]] }
```



### String matching with globbing:

```ruby
router = Hanami::Router.new
router.get '/*', to: ->(env) { [200, {}, ["This is catch all: #{ env['router.params'].inspect }!"]] }
```



### String matching with optional tokens:

```ruby
router = Hanami::Router.new
router.get '/hanami(.:format)' to: ->(env) { [200, {}, ["You've requested #{ env['router.params'][:format] }!"]] }
```



### Support for the most common HTTP methods:

```ruby
router   = Hanami::Router.new
endpoint = ->(env) { [200, {}, ['Hello from Hanami!']] }

router.get    '/hanami', to: endpoint
router.post   '/hanami', to: endpoint
router.put    '/hanami', to: endpoint
router.patch  '/hanami', to: endpoint
router.delete '/hanami', to: endpoint
router.trace  '/hanami', to: endpoint
```



### Redirect:

```ruby
router = Hanami::Router.new
router.get '/redirect_destination', to: ->(env) { [200, {}, ['Redirect destination!']] }
router.redirect '/legacy', to: '/redirect_destination'
```



### Named routes:

```ruby
router = Hanami::Router.new(scheme: 'https', host: 'hanamirb.org')
router.get '/hanami', to: ->(env) { [200, {}, ['Hello from Hanami!']] }, as: :hanami

router.path(:hanami) # => "/hanami"
router.url(:hanami)  # => "https://hanamirb.org/hanami"
```



### Namespaced routes:

```ruby
router = Hanami::Router.new
router.namespace 'animals' do
  namespace 'mammals' do
    get '/cats', to: ->(env) { [200, {}, ['Meow!']] }, as: :cats
  end
end

# and it generates:

router.path(:animals_mammals_cats) # => "/animals/mammals/cats"
```



### Mount Rack applications:

```ruby
Hanami::Router.new do
  mount RackOne,                             at: '/rack1'
  mount RackTwo,                             at: '/rack2'
  mount RackThree.new,                       at: '/rack3'
  mount ->(env) {[200, {}, ['Rack Four']]},  at: '/rack4'
  mount 'dashboard#index',                   at: '/dashboard'
end
```

1. `RackOne` is used as it is (class), because it respond to `.call`
2. `RackTwo` is initialized, because it respond to `#call`
3. `RackThree` is used as it is (object), because it respond to `#call`
4. That Proc is used as it is, because it respond to `#call`
5. That string is resolved as `Dashboard::Index` ([Hanami::Controller](https://github.com/hanami/controller) integration)



### Duck typed endpoints:

Everything that responds to `#call` is invoked as it is:

```ruby
router = Hanami::Router.new
router.get '/hanami',      to: ->(env) { [200, {}, ['Hello from Hanami!']] }
router.get '/middleware', to: Middleware
router.get '/rack-app',   to: RackApp.new
router.get '/method',     to: ActionControllerSubclass.action(:new)
```


If it's a string, it tries to instantiate a class from it:

```ruby
class RackApp
  def call(env)
    # ...
  end
end

router = Hanami::Router.new
router.get '/hanami', to: 'rack_app' # it will map to RackApp.new
```

It also supports Controller + Action syntax:

```ruby
module Flowers
  class Index
    def call(env)
      # ...
    end
  end
end

router = Hanami::Router.new
router.get '/flowers', to: 'flowers#index' # it will map to Flowers::Index.new
```



### Implicit Not Found (404):

```ruby
router = Hanami::Router.new
router.call(Rack::MockRequest.env_for('/unknown')).status # => 404
```

### Controllers:

`Hanami::Router` has a special convention for controllers naming.
It allows to declare an action as an endpoint, with a special syntax: `<controller>#<action>`.

```ruby
Hanami::Router.new do
  get '/', to: 'welcome#index'
end
```

In the example above, the router will look for the `Welcome::Index` action.

#### Namespaces

In applications where for maintainability or technical reasons, this convention
can't work, `Hanami::Router` can accept a `:namespace` option, which defines the
Ruby namespace where to look for actions.

For instance, given a Hanami full stack application called `Bookshelf`, the
controllers are available under `Bookshelf::Controllers`.

```ruby
Hanami::Router.new(namespace: Bookshelf::Controllers) do
  get '/', to: 'welcome#index'
end
```

In the example above, the router will look for the `Bookshelf::Controllers::Welcome::Index` action.

### RESTful Resource:

```ruby
router = Hanami::Router.new
router.resource 'identity'
```

It will map:

<table>
  <tr>
    <th>Verb</th>
    <th>Path</th>
    <th>Action</th>
    <th>Name</th>
    <th>Named Route</th>
  </tr>
  <tr>
    <td>GET</td>
    <td>/identity</td>
    <td>Identity::Show</td>
    <td>:show</td>
    <td>:identity</td>
  </tr>
  <tr>
    <td>GET</td>
    <td>/identity/new</td>
    <td>Identity::New</td>
    <td>:new</td>
    <td>:new_identity</td>
  </tr>
  <tr>
    <td>POST</td>
    <td>/identity</td>
    <td>Identity::Create</td>
    <td>:create</td>
    <td>:identity</td>
  </tr>
  <tr>
    <td>GET</td>
    <td>/identity/edit</td>
    <td>Identity::Edit</td>
    <td>:edit</td>
    <td>:edit_identity</td>
  </tr>
  <tr>
    <td>PATCH</td>
    <td>/identity</td>
    <td>Identity::Update</td>
    <td>:update</td>
    <td>:identity</td>
  </tr>
  <tr>
    <td>DELETE</td>
    <td>/identity</td>
    <td>Identity::Destroy</td>
    <td>:destroy</td>
    <td>:identity</td>
  </tr>
</table>

If you don't need all the default endpoints, just do:

```ruby
router = Hanami::Router.new
router.resource 'identity', only: [:edit, :update]

#### which is equivalent to:

router.resource 'identity', except: [:show, :new, :create, :destroy]
```


If you need extra endpoints:

```ruby
router = Hanami::Router.new
router.resource 'identity' do
  member do
    get 'avatar'           # maps to Identity::Avatar
  end

  collection do
    get 'authorizations'   # maps to Identity::Authorizations
  end
end

router.path(:avatar_identity)         # => /identity/avatar
router.path(:authorizations_identity) # => /identity/authorizations
```


Configure controller:

```ruby
router = Hanami::Router.new
router.resource 'profile', controller: 'identity'

router.path(:profile) # => /profile # Will route to Identity::Show
```

#### Nested Resources

We can nest resource(s):

```ruby
router = Hanami::Router.new
router.resource :identity do
  resource  :avatar
  resources :api_keys
end

router.path(:identity_avatar)       # => /identity/avatar
router.path(:new_identity_avatar)   # => /identity/avatar/new
router.path(:edit_identity_avatar)  # => /identity/avatar/new

router.path(:identity_api_keys)     # => /identity/api_keys
router.path(:identity_api_key)      # => /identity/api_keys/:id
router.path(:new_identity_api_key)  # => /identity/api_keys/new
router.path(:edit_identity_api_key) # => /identity/api_keys/:id/edit
```



### RESTful Resources:

```ruby
router = Hanami::Router.new
router.resources 'flowers'
```

It will map:

<table>
  <tr>
    <th>Verb</th>
    <th>Path</th>
    <th>Action</th>
    <th>Name</th>
    <th>Named Route</th>
  </tr>
  <tr>
    <td>GET</td>
    <td>/flowers</td>
    <td>Flowers::Index</td>
    <td>:index</td>
    <td>:flowers</td>
  </tr>
  <tr>
    <td>GET</td>
    <td>/flowers/:id</td>
    <td>Flowers::Show</td>
    <td>:show</td>
    <td>:flower</td>
  </tr>
  <tr>
    <td>GET</td>
    <td>/flowers/new</td>
    <td>Flowers::New</td>
    <td>:new</td>
    <td>:new_flower</td>
  </tr>
  <tr>
    <td>POST</td>
    <td>/flowers</td>
    <td>Flowers::Create</td>
    <td>:create</td>
    <td>:flowers</td>
  </tr>
  <tr>
    <td>GET</td>
    <td>/flowers/:id/edit</td>
    <td>Flowers::Edit</td>
    <td>:edit</td>
    <td>:edit_flower</td>
  </tr>
  <tr>
    <td>PATCH</td>
    <td>/flowers/:id</td>
    <td>Flowers::Update</td>
    <td>:update</td>
    <td>:flower</td>
  </tr>
  <tr>
    <td>DELETE</td>
    <td>/flowers/:id</td>
    <td>Flowers::Destroy</td>
    <td>:destroy</td>
    <td>:flower</td>
  </tr>
</table>


```ruby
router.path(:flowers)             # => /flowers
router.path(:flower, id: 23)      # => /flowers/23
router.path(:edit_flower, id: 23) # => /flowers/23/edit
```



If you don't need all the default endpoints, just do:

```ruby
router = Hanami::Router.new
router.resources 'flowers', only: [:new, :create, :show]

#### which is equivalent to:

router.resources 'flowers', except: [:index, :edit, :update, :destroy]
```


If you need extra endpoints:

```ruby
router = Hanami::Router.new
router.resources 'flowers' do
  member do
    get 'toggle' # maps to Flowers::Toggle
  end

  collection do
    get 'search' # maps to Flowers::Search
  end
end

router.path(:toggle_flower, id: 23)  # => /flowers/23/toggle
router.path(:search_flowers)         # => /flowers/search
```


Configure controller:

```ruby
router = Hanami::Router.new
router.resources 'blossoms', controller: 'flowers'

router.path(:blossom, id: 23) # => /blossoms/23 # Will route to Flowers::Show
```

#### Nested Resources

We can nest resource(s):

```ruby
router = Hanami::Router.new
router.resources :users do
  resource  :avatar
  resources :favorites
end

router.path(:user_avatar,      user_id: 1)  # => /users/1/avatar
router.path(:new_user_avatar,  user_id: 1)  # => /users/1/avatar/new
router.path(:edit_user_avatar, user_id: 1)  # => /users/1/avatar/edit

router.path(:user_favorites, user_id: 1)             # => /users/1/favorites
router.path(:user_favorite, user_id: 1, id: 2)       # => /users/1/favorites/2
router.path(:new_user_favorites, user_id: 1)         # => /users/1/favorites/new
router.path(:edit_user_favorites, user_id: 1, id: 2) # => /users/1/favorites/2/edit
```

### Body Parsers

Rack ignores request bodies unless they come from a form submission.
If we have a JSON endpoint, the payload isn't available in the params hash:

```ruby
Rack::Request.new(env).params # => {}
```

This feature enables body parsing for specific MIME Types.
It comes with a built-in JSON parser and allows to pass custom parsers.

#### JSON Parsing

```ruby
require 'hanami/router'

endpoint = ->(env) { [200, {},[env['router.params'].inspect]] }

router = Hanami::Router.new(parsers: [:json]) do
  patch '/books/:id', to: endpoint
end
```

```shell
curl http://localhost:2300/books/1    \
  -H "Content-Type: application/json" \
  -H "Accept: application/json"       \
  -d '{"published":"true"}'           \
  -X PATCH

# => [200, {}, ["{:published=>\"true\",:id=>\"1\"}"]]
```

If the json can't be parsed an exception is raised:

```ruby
Hanami::Routing::Parsing::BodyParsingError
```

#### Custom Parsers

```ruby
require 'hanami/router'

# See Hanami::Routing::Parsing::Parser
class XmlParser
  def mime_types
    ['application/xml', 'text/xml']
  end

  # Parse body and return a Hash
  def parse(body)
    # parse xml
  rescue SomeXmlParsingError => e
    raise Hanami::Routing::Parsing::BodyParsingError.new(e)
  end
end

endpoint = ->(env) { [200, {},[env['router.params'].inspect]] }

router = Hanami::Router.new(parsers: [XmlParser.new]) do
  patch '/authors/:id', to: endpoint
end
```

```shell
curl http://localhost:2300/authors/1 \
  -H "Content-Type: application/xml" \
  -H "Accept: application/xml"       \
  -d '<name>LG</name>'               \
  -X PATCH

# => [200, {}, ["{:name=>\"LG\",:id=>\"1\"}"]]
```

## Testing

```ruby
require 'hanami/router'

router = Hanami::Router.new do
  get '/books/:id', to: 'books#show', as: :book
end

route = router.recognize('/books/23')
route.verb      # "GET"
route.action    # => "books#show"
route.params    # => {:id=>"23"}
route.routable? # => true

route = router.recognize(:book, id: 23)
route.verb      # "GET"
route.action    # => "books#show"
route.params    # => {:id=>"23"}
route.routable? # => true

route = router.recognize('/books/23', method: :post)
route.verb      # "POST"
route.routable? # => false
```

## Versioning

__Hanami::Router__ uses [Semantic Versioning 2.0.0](http://semver.org)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Acknowledgements

Thanks to Joshua Hull ([@joshbuddy](https://github.com/joshbuddy)) for his
[http_router](http://rubygems.org/gems/http_router).

## Copyright

Copyright © 2014-2016 Luca Guidi – Released under MIT License

This project was formerly known as Lotus (`lotus-router`).
