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

end
