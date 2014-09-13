require 'spec_helper'

describe "sessions/show" do
  before(:each) do
    @session = assign(:session, stub_model(Session,
      :school_id => 1,
      :teacher_id => 2,
      :room_id => 3,
      :name => "Name",
      :summary => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
  end
end
