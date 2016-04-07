describe HelloController do 

   before :each do
   	 @client = double("client")
   	 @time = double("time")
   	 @results_helper = double("results_helper")
   	 @controller = HelloController.new(@client, @time, @results_helper) 
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
 	  it "returns a 401 when no creds are used" do
	    get :index
	    expect(response).to have_http_status(:unauthorized)
	  end
	  it "returns a 401 when invalid creds are used" do
	    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('foo', 'bar')
	    get :index
	    expect(response).to have_http_status(:unauthorized)
	  end
 	  it "returns a 200 when valid proper creds are used" do
 	  	allow(@time).to receive_message_chain('now.gmtime.strftime').with(any_args)
	    allow(@client).to receive(:search).with(any_args)
	    setup_successful_auth
	    get :index
	    expect(response).to have_http_status(:ok)
	  end	  
   end

   context "When testing the HelloController class" do 
      it "get on index calls Orchestrate client with no date param" do 
      	 filter = 'key:2016-03-05'
		 allow(@time).to receive_message_chain('now.gmtime.strftime').with("key:%Y-%m-%d").and_return(filter)
         allow(@client).to receive(:search).with(:DailyAuditorData, filter, {:sort => 'key:asc'}) 
		 setup_successful_auth
         get :index
         expect(response).to have_http_status(:ok)
      end 

      it "get on index calls Orchestrate client with date param" do 
      	 test_date = '2016-03-06'
      	 filter = 'key:' + '2016?03?06'
		 allow(@client).to receive(:search).with(:DailyAuditorData, filter, {:sort => 'key:asc'}) 
         setup_successful_auth
         get :index, :date => test_date
         expect(response).to have_http_status(:ok)
      end
   end

   def setup_successful_auth
	  request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('username', 'password')
   end

end
