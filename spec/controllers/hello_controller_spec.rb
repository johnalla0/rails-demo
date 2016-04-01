describe HelloController do 
   context "When testing the HelloController class" do 
      
      it "should set the greeting field to 'Hello World!'" do 
         hc = HelloController.new 
         message = hc.greeting
         expect(message).to eq "Hello World!"
      end
      
   end
end
