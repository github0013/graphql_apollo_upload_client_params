require "spec_helper"
module GraphqlApolloUploadClientParams
  module Converters
    RSpec.describe Base do
      describe :private do
        subject{ GraphqlApolloUploadClientParams::Converters::Base.new({}) }
        describe :ensure_hash do
          context "string" do
            let(:value){ "" }
            it{ expect(subject.send :ensure_hash, value).to eq({}) }
          end
          context "json" do
            let(:value){ {a: 1}.to_json }
            it{ expect(subject.send :ensure_hash, value).to eq({"a" => 1}) }
          end
          context "hash" do
            let(:value){ {a: 1} }
            it{ expect(subject.send :ensure_hash, value).to eq({a: 1}) }
          end
        end
      end
    end
  end
end