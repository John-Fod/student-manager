require 'spec_helper'

describe "sessions/new" do
  before(:each) do
    assign(:session, stub_model(Session,
      :school_id => 1,
      :teacher_id => 1,
      :room_id => 1,
      :name => "MyString",
      :summary => "MyText"
    ).as_new_record)
  end

  it "renders new session form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", sessions_path, "post" do
      assert_select "input#session_school_id[name=?]", "session[school_id]"
      assert_select "input#session_teacher_id[name=?]", "session[teacher_id]"
      assert_select "input#session_room_id[name=?]", "session[room_id]"
      assert_select "input#session_name[name=?]", "session[name]"
      assert_select "textarea#session_summary[name=?]", "session[summary]"
    end
  end
end
