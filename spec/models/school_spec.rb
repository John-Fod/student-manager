require 'spec_helper'

describe School do
  
  it "should be editable by it's headmaster" do
  	teacher = FactoryGirl.create(:teacher, :name => "akahige", :password => "123")
  	school = FacotoryGirl.create(:school, :headmaster => teacher)

  	school.editable_by?(teacher).should == true
  end

end
