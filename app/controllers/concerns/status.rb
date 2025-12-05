module Status extend ActiveSupport::Concern

	PAST_ALLOWANCE_SECONDS = 600
	FUTURE_ALLOWANCE_SECONDS = 1
	
	def current_status
		status_file_path = Rails.configuration.current_status_file
		json = JSON.parse(File.read(status_file_path))
		return status_for_hash(json)
	end
	
	def prior_status
		status_file_path = Rails.configuration.prior_status_file
		if !File.exist?(status_file_path)
			return nil
		end
		json = JSON.parse(File.read(status_file_path))
		if json["status"] == "good"
			return :good
		end
		if json["status"] == "warn"
			return :warn
		end
		if json["status"] == "warning"
			return :warn
		end
		return :error
	end
	
	def status_for_hash(hash)
		if hash.nil? or !hash.is_a?(Hash)
			Rails.logger.info("returning error because not an error")
			return :error_bad_time
		end
		
		ts = hash["ts"]
		if ts.nil? or !ts.is_a?(Integer)
			return :error_bad_time
		end
		now_ts = Time.now.to_i
		
		if ts < now_ts - PAST_ALLOWANCE_SECONDS
			Rails.logger.info("returning error ts too old")
			return :error_bad_time
		end
		if ts > now_ts + FUTURE_ALLOWANCE_SECONDS
			Rails.logger.info("returning error ts too new")
			return :error_bad_time
		end
		
		if hash["status"] == "good"
			return :good
		end
		if hash["status"] == "warn"
			return :warn
		end
		if hash["status"] == "warning"
			return :warn
		end
		return :error
	end

end
