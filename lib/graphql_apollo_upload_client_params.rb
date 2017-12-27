require "active_support"
require 'active_support/core_ext'

require "graphql_apollo_upload_client_params/version"
require "graphql_apollo_upload_client_params/converters/base"
require "graphql_apollo_upload_client_params/converters/regular"
require "graphql_apollo_upload_client_params/converters/apollo_upload_client"

module GraphqlApolloUploadClientParams
  extend self
  def convert(params)
    class_name = params.key?(:operations) ? Converters::ApolloUploadClient : Converters::Regular
    class_name.new(params)
  end
end
