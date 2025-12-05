class CurrentController < ApplicationController

	include Status

	def show_status
		status_file_path = Rails.configuration.current_status_file
		json = JSON.parse(File.read(status_file_path))
		result = Hash.new
		result["status"] = json["status"]
		result["last_generated"] = Time.at(json["ts"]).to_fs(:rfc822)
		result["warnings"] = json["warnings"]
		result["errors"] = json["errors"]
		response.headers['Content-Type'] = 'application/json'
		render :body => JSON.pretty_generate(result)
	end

	def high
		status = current_status()
		if status == :error_bad_time
			render :json => {}, :status => :internal_server_error
			return
		end
		if status == :good or status == :warn
			render :json => {}
			return
		end
		prior_status = prior_status()
		if !prior_status.nil?
			if prior_status == :good or prior_status == :warn
				render :json => {}
				return
			end
		end
		render :json => {}, :status => :internal_server_error
	end

	def low
		status = current_status()
		if status == :error_bad_time
			render :json => {}, :status => :internal_server_error
			return
		end
		if status == :good
			render :json => {}
			return
		end
		prior_status = prior_status()
		if !prior_status.nil?
			if prior_status == :good
				render :json => {}
				return
			end
		end
		render :json => {}, :status => :internal_server_error
	end

end
