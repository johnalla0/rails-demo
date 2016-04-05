describe HelloController do 

   before :each do
   	 @controller = HelloController.new(nil) 
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
	    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('username', 'password')
	    get :index
	    expect(response).to have_http_status(:ok)
	    expect(response.body).to match /Hello World/
	  end	  
   end

   context "When testing the HelloController class" do 
      it "should set the greeting field to 'Hello World!'" do 
         @controller.index
         message = @controller.instance_variable_get(:@greeting)
         expect(message).to eq "Hello World!"
      end
   end
=begin
   context "Orchestrate client cool stuff"
   		let(:client) {mock('client')}
   		it "gets passed to the right place" do
   			hc = HelloController.new(client)
   end
=end
end
