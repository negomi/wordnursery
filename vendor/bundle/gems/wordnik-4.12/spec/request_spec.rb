require 'spec_helper'

describe Wordnik::Request do

  before(:each) do
    @default_http_method = :get
    @default_path = "words/fancy"
    @default_params = {
      :params => {:foo => "1", :bar => "2"}
    }
    @request = Wordnik::Request.new(@default_http_method, @default_path, @default_params)
  end

  describe "initialization" do
    it "sets default response format to json" do
      @request.format.should == 'json'
    end

    it "allows params to be nil" do
      @request = Wordnik::Request.new(@default_http_method, @default_path, :params => nil)
      @request.query_string.should == ""
    end

  end

  describe "attr_accessors" do

    it "has working attributes" do
      @request.format.to_s.should == 'json'
    end

    it "allows attributes to be overwritten" do
      @request.http_method.should == :get
      @request.http_method = "post"
      @request.http_method.should == 'post'
    end

  end

  describe "url" do

    it "constructs a query string" do
      @request.query_string.should == "?bar=2&foo=1"
    end

    it "constructs a full url" do
      @request.url.has_suffix?("#{Wordnik.configuration.base_path}/words.json/fancy?bar=2&foo=1").should == true
    end

  end

  describe "body" do

    it "camelCases parameters" do
      @request = Wordnik::Request.new(@default_http_method, @default_path, @default_params.merge({
        :body => {
          :bad_dog => 'bud',
          :goodDog => "dud"
        }
      }))
      @request.body.keys.should == [:badDog, :goodDog]
    end

  end

  describe "path" do

    it "accounts for a total absence of format in the path string" do
      @request = Wordnik::Request.new(:get, "/word/{word}/entries", @default_params.merge({
        :format => "xml",
        :params => {
          :word => "cat"
        }
      }))
      @request.url.has_suffix?("#{Wordnik.configuration.base_path}/word.xml/cat/entries").should == true
    end

    it "does string substitution on path params" do
      @request = Wordnik::Request.new(:get, "/word.{format}/{word}/entries", @default_params.merge({
        :format => "xml",
        :params => {
          :word => "cat"
        }
      }))
      @request.url.has_suffix?("#{Wordnik.configuration.base_path}/word.xml/cat/entries").should == true
    end

    it "leaves path-bound params out of the query string" do
      @request = Wordnik::Request.new(:get, "/word.{format}/{word}/entries", @default_params.merge({
        :params => {
          :word => "cat",
          :limit => 20
        }
      }))
      @request.query_string.should == "?limit=20"
    end

    it "returns a question-mark free (blank) query string if no query params are present" do
      @request = Wordnik::Request.new(:get, "/word.{format}/{word}/entries", @default_params.merge({
        :params => {
          :word => "cat",
        }
      }))
      @request.query_string.should == ""
    end

    it "removes blank params" do
      @request = Wordnik::Request.new(:get, "words/fancy", @default_params.merge({
        :params => {
          :word => "dog",
          :limit => "",
          :foo => "criminy"
        }
      }))
      @request.query_string.should == "?foo=criminy&word=dog"
    end

    it "URI encodes the path" do
      @request = Wordnik::Request.new(:get, "word.{format}/{word}/definitions", @default_params.merge({
        :params => {
          :word => "bill gates"
        }
      }))
      @request.url.should =~ /word.json\/bill\%20gates\/definitions/
    end

    it "converts numeric params to strings" do
      @request = Wordnik::Request.new(@default_http_method, @default_path, @default_params.merge({
        :params => {
          :limit => 100
        }
      }))

      @request.interpreted_path.should_not be_nil
      @request.query_string.should =~ /\?limit=100/
      @request.url.should =~ /\?limit=100/
    end

    it "camelCases parameters" do
      @request = Wordnik::Request.new(@default_http_method, @default_path, @default_params.merge({
        :params => {
          :bad_dog => 'bud',
          :goodDog => "dud"
        }
      }))
      @request.query_string.should == "?badDog=bud&goodDog=dud"
    end

    it "converts boolean values to their string representation" do
      params = {:stringy => "fish", :truthy => true, :falsey => false}
      @request = Wordnik::Request.new(:get, 'fakeMethod', :params => params)
      @request.query_string.should == "?falsey=false&stringy=fish&truthy=true"
    end

  end

  describe "API key" do

    it "is inferred from the Wordnik base configuration by default" do
      Wordnik.configure {|c| c.api_key = "xyz" }
      Wordnik::Request.new(:get, "word/json").headers[:api_key].should == "xyz"
    end

    it "can be obfuscated for public display" do
      @request = Wordnik::Request.new(:get, "words/fancy", @default_params.merge({
        :params => {
          :word => "dog",
          :api_key => "123456"
        }
      }))

      @request.url.should =~ /api\_key=123456/
      @request.url(:obfuscated => true).should =~ /api\_key=YOUR\_API\_KEY/
    end

    it "allows a key in the params to override the configuration-level key, even if it's blank" do
      Wordnik.configure {|c| c.api_key = "abc" }
      @request_with_key = Wordnik::Request.new(:get, "word/json", :params => {:api_key => "jkl"})
      @request_with_key.headers[:api_key].should be_nil
      @request_with_key.params[:api_key].should == "jkl"

      @request_without_key = Wordnik::Request.new(:get, "word/json", :params => {:api_key => nil})
      @request_without_key.headers[:api_key].should be_nil
      @request_without_key.params[:api_key].should be_nil
    end

    it "allows a key in the headers to override the configuration-level key, even if it's blank" do
      Wordnik.configure {|c| c.api_key = "hij" }
      Wordnik::Request.new(:get, "word/json").headers[:api_key].should == "hij"
      Wordnik::Request.new(:get, "word/json", :headers => {:api_key => "jkl"}).headers[:api_key].should == "jkl"
      Wordnik::Request.new(:get, "word/json", :headers => {:api_key => nil}).headers[:api_key].should be_nil
    end

  end

end
