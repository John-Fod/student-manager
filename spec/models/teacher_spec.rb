require 'spec_helper'

describe Teacher do
  

  it "should authenticate with matching email and password" do
  	teacher = FactoryGirl.create(:teacher, :name => "akahige", :password => "123")
  	Teacher.authenticate('akahige@gmail.com', '123').should == teacher
  end


  it "should authenticate with matching username and password" do
  	teacher = FactoryGirl.create(:teacher, :name => "Akahige", :password => "123")
  	Teacher.authenticate('Akahige', '123').should == teacher
  end


  it "should not authenticate with an incorrect password" do 
  	teacher = FactoryGirl.create(:teacher, :name => "akahige", :password => "123")
  	Teacher.authenticate('akahige@gmail.com', '456').should be_nil
  end


  it "should not authenticate with an incorrect username" do 
    teacher = FactoryGirl.create(:teacher, :name => "akahige", :password => "123")
    Teacher.authenticate('john@gmail.com', '123').should be_nil
  end


  it "should be editable by the teacher" do
    teacher = FactoryGirl.create(:teacher, :name => "akahige", :password => "123")
    teacher.editable_by?(teacher).should == true
  end


  it "should not be editable by another teacher" do
    teacher = FactoryGirl.create(:teacher, :name => "akahige", :password => "123")
    false_teacher = FactoryGirl.create(:teacher, :name => "john", :password => "123")
    teacher.editable_by?(false_teacher).should == nil
  end


  it "should not be editable by no teacher" do
    teacher = FactoryGirl.create(:teacher, :name => "akahige", :password => "123")
    teacher.editable_by?.should == nil

  end

end
