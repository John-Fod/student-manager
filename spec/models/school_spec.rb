require 'spec_helper'

describe School do
  
  it "should be editable by it's headmaster" do
  	teacher = FactoryGirl.create(:teacher, :name => "akahige", :password => "123")
  	school = FactoryGirl.create(:school, :headmaster_id => teacher.to_param)

  	school.editable_by?(teacher).should == true
  end

  it "should not be editable by a teacher who isn't it's headmaster" do
  	false_teacher = FactoryGirl.create(:teacher, :name => "john", :password => "123")
  	teacher = FactoryGirl.create(:teacher, :name => "akahige", :password => "123")
  	school = FactoryGirl.create(:school, :headmaster_id => teacher.to_param)

  	school.editable_by?(false_teacher).should == nil
  end

  it "should not be editable without a teacher" do
  	teacher = FactoryGirl.create(:teacher, :name => "akahige", :password => "123")
  	school = FactoryGirl.create(:school, :headmaster_id => teacher.to_param)

  	school.editable_by?.should == nil
  end

end
