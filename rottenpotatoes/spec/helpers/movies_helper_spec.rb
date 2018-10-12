require 'rails_helper'

describe MoviesHelper do
    it "returns false" do
        expect(helper.oddness(2)).to eq("even")
    end
    it "returns true" do
        expect(helper.oddness(3)).to eq("odd")
    end
end
