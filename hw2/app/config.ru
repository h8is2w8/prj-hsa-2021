require 'elasticsearch'
require 'roda'
require 'sequel'

DATABASE_URL = ENV.fetch(
  'DATABASE_URL',
  'postgresql://user:pass@db:5432/demo'
)


ELASTIC = Elasticsearch::Client.new(host: 'elastic:9200', log: true)

DB = Sequel.connect(DATABASE_URL)

class HelloWorld < Roda
  plugin :all_verbs
  plugin :json, classes: [Array, Hash]
  plugin :json_parser

  route do |r|
    r.get 'posts' do
      posts = DB[:posts]
      posts.map(&:to_json)
    end

    r.post 'logs' do
      ELASTIC.index(
        index: 'logs',
        type: 'object',
        body: r.params
      )
    end
  end
end

run HelloWorld.freeze.app
