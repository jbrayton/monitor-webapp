require 'test_helper'

class StackControllerTest < ActionController::TestCase

	test "status_for_hash" do
		assert_equal(:good, @controller.status_for_hash({"status" => "good", "ts" => Time.now.to_i}))
		assert_equal(:good, @controller.status_for_hash({"status" => "good", "ts" => Time.now.to_i - 118}))
		assert_equal(:error, @controller.status_for_hash({"status" => "error", "ts" => Time.now.to_i - 122}))
		assert_equal(:error_bad_time, @controller.status_for_hash({"status" => "error", "ts" => Time.now.to_i + 5}))

		assert_equal(:error, @controller.status_for_hash({"status" => "error", "ts" => Time.now.to_i}))
		assert_equal(:warn, @controller.status_for_hash({"status" => "warn", "ts" => Time.now.to_i}))

		assert_equal(:error_bad_time, @controller.status_for_hash({"status" => "good"}))
		assert_equal(:error_bad_time, @controller.status_for_hash({"status" => "good", "ts" => "xsf"}))
		assert_equal(:error, @controller.status_for_hash({"status" => "sfsdf", "ts" => Time.now.to_i}))
		assert_equal(:error, @controller.status_for_hash({"status" => {"a" => "b"}, "ts" => Time.now.to_i}))
		assert_equal(:error, @controller.status_for_hash({"ts" => Time.now.to_i}))
		assert_equal(:error_bad_time, @controller.status_for_hash({}))
		assert_equal(:error_bad_time, @controller.status_for_hash(3))
		assert_equal(:error_bad_time, @controller.status_for_hash(nil))
	end

end
