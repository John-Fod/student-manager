require File.dirname(__FILE__) + '/../spec_helper'

describe Teacher do
  
  it "should authenticate with matching email and password" do
  	teacher = FactoryGirl.create(:teacher, :teachername => "akahige", :password => "123")
  	Teacher.authenticate('akahige@gmail.com', '123').should == teacher
  end

  it "should not authenticate with an incorrect password" do 
  	teacher = FactoryGirl.create(:teacher, :teachername => "akahige", :password => "123")
  	Teacher.authenticate('akahige@gmail.com', '456').should be_nil
  end

end
