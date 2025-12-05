class StackController < ApplicationController

	include Status

	PRIORITIES = ["high", "low"]
	
	HEALTHY_STRING = "com.goldenhillsoftware.systemishealthy"
	SOMETHING_WRONG = "something is wrong"

	def show_status
		stacks = Rails.configuration.stacks
		stack_file = stacks[params["stack_id"]]
		if stack_file.nil?
			render :status => 404
			return
		end
		priority = params["priority"]
		if !PRIORITIES.include?(priority)
			render :status => 404
			return
		end

		if !File.exist?(stack_file)
			Rails.logger.info("returning error because cannot find #{stack_file}")
			render :html => SOMETHING_WRONG, :status => :internal_server_error
			return
		end
		
		json = JSON.parse(File.read(stack_file))
		status = status_for_hash(json)
		
		if status == :good
			render :html => HEALTHY_STRING
			return
		end
		if status == :warn and priority == "high"
			render :html => HEALTHY_STRING
			return
		end
		
		Rails.logger.info("returning error because status is .#{status}.")
		render :html => SOMETHING_WRONG, :status => :internal_server_error
	end

end
