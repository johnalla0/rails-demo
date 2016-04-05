describe HelloController do 

   before :each do
   	 @client = double("client")
   	 @time = double("time")
   	 @controller = HelloController.new(@client, @time) 
   end

   render_views

   context "Route for HelloController class" do
	  it "routes /hello to the HelloController" do
	    expect({ :get => "/hello" }).to route_to(:controller => "hello", :action => "index")
	  end
	  it "routes / to the HelloController" do
	    expect({ :get => "/" }).to route_to(:controller => "hello", :action => "index")
	  end
   end

   context "Basic Auth for HelloController class" do
 	  it "no creds 401" do
	    get :index
	    expect(response).to have_http_status(:unauthorized)
	  end
	  it "invalid creds 401" do
	    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('foo', 'bar')
	    get :index
	    expect(response).to have_http_status(:unauthorized)
	  end
 	  it "proper creds" do
 	  	allow(@time).to receive_message_chain('now.gmtime.strftime').with(any_args)
	    allow(@client).to receive(:search).with(any_args)
	    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('username', 'password')
	    get :index
	    expect(response).to have_http_status(:ok)
	    expect(response.body).to match /Hello World/
	  end	  
   end

   context "When testing the HelloController class" do 
      it "should set the greeting field to 'Hello World!'" do 
		 allow(@time).to receive_message_chain('now.gmtime.strftime').with("key:%Y-%m-%d").and_return('key:2016-03-05')
		 allow(@client).to receive(:search).with(:DailyAuditorData, 'key:2016-03-05', {:sort => 'key:asc'}) 
         @controller.index
         greeting = @controller.instance_variable_get(:@greeting)
         expect(greeting).to eq "Hello World!"
      end
   end
end
