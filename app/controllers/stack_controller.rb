class StackController < ApplicationController

	PAST_ALLOWANCE_SECONDS = 240
	FUTURE_ALLOWANCE_SECONDS = 1
	
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
			render :html => SOMETHING_WRONG
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
		
		render :html => SOMETHING_WRONG
	end

	def status_for_hash(hash)
		if hash.nil? or !hash.is_a?(Hash)
			return :error
		end
		
		ts = hash["ts"]
		if ts.nil? or !ts.is_a?(Integer)
			return :error
		end
		now_ts = Time.now.to_i
		
		if ts < now_ts - PAST_ALLOWANCE_SECONDS
			return :error
		end
		if ts > now_ts + FUTURE_ALLOWANCE_SECONDS
			return :error
		end
		
		if hash["status"] == "good"
			return :good
		end
		if hash["status"] == "warn"
			return :warn
		end
		return :error
	end

end
