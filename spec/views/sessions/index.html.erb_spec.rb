require 'spec_helper'

describe "sessions/index" do
  before(:each) do
    assign(:sessions, [
      stub_model(Session,
        :school_id => 1,
        :teacher_id => 2,
        :room_id => 3,
        :name => "Name",
        :summary => "MyText"
      ),
      stub_model(Session,
        :school_id => 1,
        :teacher_id => 2,
        :room_id => 3,
        :name => "Name",
        :summary => "MyText"
      )
    ])
  end

  it "renders a list of sessions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
