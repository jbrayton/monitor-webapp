require "test_helper"

class CurrentControllerTest < ActionDispatch::IntegrationTest

	test "check status" do
	
		File.write(Rails.configuration.current_status_file, JSON.generate({"status" => "good", "ts" => Time.now.to_i, "warnings" => [], "errors" => [] }))
		
		get "/current"
		assert_equal 200, @response.status
		json = JSON.parse(@response.body)
		assert_equal "good", json["status"]
		assert_not_nil json["last_generated"]
		assert_equal [], json["warnings"]
		assert_equal [], json["errors"]
		
		File.write(Rails.configuration.current_status_file, JSON.generate({"status" => "good", "ts" => Time.now.to_i, "warnings" => ["1","2","3"], "errors" => ["a","b","c"] }))
		
		get "/current"
		assert_equal 200, @response.status
		json = JSON.parse(@response.body)
		assert_equal "good", json["status"]
		assert_not_nil json["last_generated"]
		assert_equal ["1","2","3"], json["warnings"]
		assert_equal ["a","b","c"], json["errors"]
		
	end

end
