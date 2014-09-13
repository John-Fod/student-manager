require 'spec_helper'

describe "class_sessions/show" do
  before(:each) do
    @class_session = assign(:class_session, stub_model(ClassSession,
      :room_id => 1,
      :teacher_id => 2,
      :school_id => 3,
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
