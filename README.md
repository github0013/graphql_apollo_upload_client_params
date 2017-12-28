# GraphqlApolloUploadClientParams

apollo-client v2 + rails (graphql-ruby) to upload files in mutation.

```js
// if upload a file like this
this.props
  .mutate({
    variables: {
      file: uploadingFileObject
    }
  })
  .then();
```

```ruby
# then the server receives params like this
# params[:operations] => json containing query and variables
# params[:map] => json containing uploaded file mapping data
# params["0"..] => number string key containing the actual file object ActionDispatch::Http::UploadedFile

class GraphqlController < ApplicationController

  def execute
    # this gem will try to convert the params to useful variables, query, operation_name
    converted_params = GraphqlApolloUploadClientParams.convert(params)
    variables = converted_params.variables
    query = converted_params.query
    operation_name = converted_params.operation_name
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'graphql_apollo_upload_client_params', path: "clone this repo and point to your local path"
```

And then execute:

    $ bundle

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/graphql_apollo_upload_client_params.
