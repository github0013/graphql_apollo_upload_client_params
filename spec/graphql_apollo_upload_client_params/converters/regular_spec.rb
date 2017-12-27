require "spec_helper"
module GraphqlApolloUploadClientParams
  module Converters
    RSpec.describe Regular do
      subject{ GraphqlApolloUploadClientParams::Converters::Regular.new params }
      describe :variables do
        let(:params) do
          {
            variables: {a: 1}.to_json
          }.with_indifferent_access
        end
        it{ expect(subject.variables).to eq({"a" => 1}) }
      end

      describe :query do
        let(:query) do
          <<~GQL
            query {
              test{
                name
              }
            }
          GQL
        end
        let(:params) do
          {
            query: query
          }.with_indifferent_access
        end

        it{ expect(subject.query).to eq query }
      end

      describe :operation_name do
        let(:params) do
          {
            operationName: "name"
          }.with_indifferent_access
        end

        it{ expect(subject.operation_name).to eq "name" }
      end
    end
  end
end