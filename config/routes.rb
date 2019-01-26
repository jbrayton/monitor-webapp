Rails.application.routes.draw do

	controller :stack do
		get '/1.0/stacks/:stack_id/:priority' => :show_status, :format => false
	end

	controller :hello do
		get '/' => :hello, :format => false
	end

end
