require 'spec_helper'

describe "sessions/edit" do
  before(:each) do
    @session = assign(:session, stub_model(Session,
      :school_id => 1,
      :teacher_id => 1,
      :room_id => 1,
      :name => "MyString",
      :summary => "MyText"
    ))
  end

  it "renders the edit session form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", session_path(@session), "post" do
      assert_select "input#session_school_id[name=?]", "session[school_id]"
      assert_select "input#session_teacher_id[name=?]", "session[teacher_id]"
      assert_select "input#session_room_id[name=?]", "session[room_id]"
      assert_select "input#session_name[name=?]", "session[name]"
      assert_select "textarea#session_summary[name=?]", "session[summary]"
    end
  end
end
