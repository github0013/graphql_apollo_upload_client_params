require "spec_helper"
module GraphqlApolloUploadClientParams
  module Converters
    RSpec.describe ApolloUploadClient do
      subject{ GraphqlApolloUploadClientParams::Converters::ApolloUploadClient.new params }
      let(:params){ {} }
      let(:query) do
        <<~GQL
          query {
            test{
              name
            }
          }
        GQL
      end

      describe :variables do
        context "no file map" do
          let(:params) do
            {
              map: {},
              operations: ({
                variables: {a: 1},
              }.to_json)
            }.with_indifferent_access
          end
          it{ expect(subject.variables).to eq({"a" => 1}) }
        end

        context "has file map" do
          let(:file){ "file object 0" }
          let(:params) do
            {
              map: {
                "0" => ["variables.a.0.x"]
              }.to_json,
              "0" => file,
              operations: ({
                variables: {a: [{}]},
              }.to_json)
            }.with_indifferent_access
          end
          it{ expect(subject.variables).to eq({"a" => [{"x" => file}]}) }
        end
      end

      describe :query do
        let(:params) do
          {
            operations: ({
              query: query,
            }.to_json)
          }.with_indifferent_access
        end
        it{ expect(subject.query).to eq query }
      end

      describe :operation_name do
        context "no operationName key" do
          let(:params) do
            {
              operations: ({
              }.to_json)
            }.with_indifferent_access
          end
          it{ expect(subject.operation_name).to be_nil }
        end

        context "has operationName" do
          let(:params) do
            {
              operations: ({
                operationName: "name",
              }.to_json)
            }.with_indifferent_access
          end
          it{ expect(subject.operation_name).to eq "name" }
        end
      end

      describe :private do

        describe :operations do
          let(:params) do
            {
              operations: ({
              }.to_json)
            }.with_indifferent_access
          end
          it{ expect(subject.send :operations).to match String }
        end

        describe :map do
          context "string" do
            let(:params) do
              {
                map: {a: 1}.to_json
              }
            end
            it{ expect(subject.send :map).to eq({"a" => 1}) }
          end

          context nil do
            let(:params) do
              {
                map: nil
              }
            end
            it{ expect(subject.send :map).to eq({}) }
          end
        end

        describe :set_file_at_end do
          let(:file){ "file" }
          context "no index" do
            let(:value){ {"a" => {"b" => {}}} }
            it{ expect(subject.send :set_file_at_end, value, "a.b.c", file).to eq file }
          end

          context "index in between" do
            let(:value){ {"a" => [{}]} }
            it{ expect(subject.send :set_file_at_end, value, "a.0.c", file).to eq file }
          end

          context "index in between" do
            let(:value){ {"a" => {"b" => []} } }
            it{ expect(subject.send :set_file_at_end, value, "a.b.0", file).to eq file }
          end
        end

        describe :file_mapping do
          let(:params) do
            {
              map: {
                "0" => ["variables.model.0"]
              }.to_json,
              "0" => "file object 0",
            }.with_indifferent_access
          end
          let(:variables){ {model: []} }

          it do
            expect{
              subject.send :file_mapping, variables
            }.to change{
              variables[:model]
            }.to(["file object 0"])
          end
        end
      end
    end
  end
end