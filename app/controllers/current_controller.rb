class CurrentController < ApplicationController

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
		status_file_path = Rails.configuration.current_status_file
		json = JSON.parse(File.read(status_file_path))
		if json["status"] == "good"
			render :json => {}
			return
		end
		if json["status"] == "warn"
			render :json => {}
			return
		end
		if json["status"] == "warning"
			render :json => {}
			return
		end
		render :json => {}, :status => :internal_server_error
	end

	def low
		status_file_path = Rails.configuration.current_status_file
		json = JSON.parse(File.read(status_file_path))
		if json["status"] == "good"
			render :json => {}
			return
		end
		render :json => {}, :status => :internal_server_error
	end

end
