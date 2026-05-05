# frozen_string_literal: true

require "./index"
require "minitest/autorun"
require "rack/test"

# Unit tests for the backend of the web application.
class MfiCutoffAssistantTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application.tap { |a| a.set :environment, :test }
  end

  def test_landing_page
    get "/"
    assert_equal 200, last_response.status
  end

  def test_version_endpoint
    get "/version"
    assert_equal 200, last_response.status
  end

  def test_run_endpoint_with_fake_data
    get "/run", { mfis: "1-2-3-4-5-8-9-9-10-10" }
    assert_equal 200, last_response.status
    assert_equal "8", last_response.body
  end

  def test_run_endpoint_with_real_data
    get "/run", {
      mfis: "7782-6899-6726-4387-3728-3682-2514-1657-1493-1397-1375-1302-1263
            -1257-1229-1072-968-939-840-836-830-749-647-532-529-501-499-491
            -485-336-299-298-267-255-253-241-217-215-199-172-168-167-144-139
            -134-131-114-110-100-94-72-68-68-64-60-58-56-44-32-32-23-18-17
            -13-3-3-1-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0
            -0-0",
    }

    assert_equal 200, last_response.status
    assert_equal "3682", last_response.body
  end
end
