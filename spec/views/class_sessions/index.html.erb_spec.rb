require 'spec_helper'

describe "class_sessions/index" do
  before(:each) do
    assign(:class_sessions, [
      stub_model(ClassSession,
        :room_id => 1,
        :teacher_id => 2,
        :school_id => 3,
        :name => "Name",
        :summary => "MyText"
      ),
      stub_model(ClassSession,
        :room_id => 1,
        :teacher_id => 2,
        :school_id => 3,
        :name => "Name",
        :summary => "MyText"
      )
    ])
  end

  it "renders a list of class_sessions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
