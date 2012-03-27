require 'spec_helper'
require 'pp'

describe I18n::Validator do
  it "should find missing locales" do
    missing_locales = I18n::Validator::missing_locales(Dir[File.join(File.dirname(__FILE__), "fixtures", "locales", "*")])

    missing_locales.should eql([
      ["hello.kitty", [:de, :en]],
      ["hello.world", [:de]]
    ])
  end
end