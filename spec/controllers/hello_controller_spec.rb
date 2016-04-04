describe HelloController do 
render_views

   context "Route for HelloController class" do
	  it "routes /hello to the HelloController" do
	    { :get => "/hello" }.should route_to(:controller => "hello", :action => "index")
	    expect(response).to have_http_status(:ok)
	  end
	  it "routes / to the HelloController" do
	    { :get => "/" }.should route_to(:controller => "hello", :action => "index")
	    expect(response).to have_http_status(:ok)
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
=begin
   context "When testing the HelloController class" do 
      it "should be behind basic auth'" do 
         hc = HelloController.new 
         AuthHelper.http_login
		 get "/hello"
		 assert_equal 200, status
      end
   end
end
=begin
describe HelloController do
  render_views

  # login to http basic auth
  include AuthHelper
  before(:each) do
    http_login
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

end
=end