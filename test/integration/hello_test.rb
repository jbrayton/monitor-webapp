require 'test_helper'

class HelloTest < ActionDispatch::IntegrationTest

	test "hello" do
		get "/"
		assert_equal 200, @response.status
		assert_equal "text/html; charset=utf-8", @response.headers["Content-Type"]
		assert_equal response.body, "hello"
	end

end
