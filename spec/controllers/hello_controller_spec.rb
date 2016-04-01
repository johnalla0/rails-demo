describe HelloController do 
   context "When testing the HelloController class" do 
      
      it "should set the greeting field to 'Hello World!'" do 
         hc = HelloController.new 
         hc.index
         message = hc.instance_variable_get(:@greeting)
         expect(message).to eq "Hello World!"
      end
      
   end
end
