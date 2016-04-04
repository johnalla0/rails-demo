describe HelloController do 

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
	  it "invalid creds XXX" do
	    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('foo', 'bar')
	    get :index
	    expect(response).to have_http_status(:unauthorized)
	  end
 	  it "proper creds" do
	    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('username', 'password')
	    get :index
	    expect(response).to have_http_status(:ok)
	    expect(response.body).to match /Hello World/
	  end	  
   end

   context "When testing the HelloController class" do 
      it "should set the greeting field to 'Hello World!'" do 
         hc = HelloController.new 
         hc.index
         message = hc.instance_variable_get(:@greeting)
         expect(message).to eq "Hello World!"
      end
   end
end
