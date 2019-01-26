require 'test_helper'

class StackTest < ActionDispatch::IntegrationTest

	TEST_FILE_PATH = "/Users/jbrayton/Documents/monitor-webapp/test_result_files/testfile.json"

	HEALTHY_STRING = "com.goldenhillsoftware.systemishealthy"
	SOMETHING_WRONG = "something is wrong"

	test "check status" do
	
		File.delete(TEST_FILE_PATH) if File.exist?(TEST_FILE_PATH)
	
		get "/1.0/stacks/foobar/high"
		assert_equal 404, @response.status
		
		get "/1.0/stacks/foobar/low"
		assert_equal 404, @response.status
		
		get "/1.0/stacks/mystack/affaadfadf"
		assert_equal 404, @response.status
		
		get "/1.0/stacks/mystack/high"
		assert_equal 200, @response.status
		assert_equal SOMETHING_WRONG, @response.body
		
		get "/1.0/stacks/mystack/low"
		assert_equal 200, @response.status
		assert_equal SOMETHING_WRONG, @response.body
		
		File.write(TEST_FILE_PATH, JSON.generate({"status" => "good", "ts" => Time.now.to_i }))
		
		get "/1.0/stacks/mystack/high"
		assert_equal 200, @response.status
		assert_equal HEALTHY_STRING, @response.body
		
		get "/1.0/stacks/mystack/low"
		assert_equal 200, @response.status
		assert_equal HEALTHY_STRING, @response.body
		
		File.write(TEST_FILE_PATH, JSON.generate({"status" => "warn", "ts" => Time.now.to_i }))
		
		get "/1.0/stacks/mystack/high"
		assert_equal 200, @response.status
		assert_equal HEALTHY_STRING, @response.body
		
		get "/1.0/stacks/mystack/low"
		assert_equal 200, @response.status
		assert_equal SOMETHING_WRONG, @response.body
		
		File.write(TEST_FILE_PATH, JSON.generate({"status" => "error", "ts" => Time.now.to_i }))
		
		get "/1.0/stacks/mystack/high"
		assert_equal 200, @response.status
		assert_equal SOMETHING_WRONG, @response.body
		
		get "/1.0/stacks/mystack/low"
		assert_equal 200, @response.status
		assert_equal SOMETHING_WRONG, @response.body
		
	end

end
