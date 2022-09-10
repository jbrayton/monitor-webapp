require "test_helper"

class HealthCheckTest < ActionDispatch::IntegrationTest

	test "health" do
		get "/health_check"
		assert_equal 200, @response.status
		assert_equal "success", @response.body
	end

end
