Rails.application.routes.draw do

	controller :stack do
		get '/1.0/monitors/:stack_id/priorities/:priority' => :show_status, :format => false
	end

	controller :current do
		get '/current' => :show_status, :format => false
		get '/high' => :high, :format => false
		get '/low' => :low, :format => false
	end

	controller :hello do
		get '/' => :hello, :format => false
	end

end
