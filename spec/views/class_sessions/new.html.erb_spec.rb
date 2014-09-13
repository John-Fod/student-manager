require 'spec_helper'

describe "class_sessions/new" do
  before(:each) do
    assign(:class_session, stub_model(ClassSession,
      :room_id => 1,
      :teacher_id => 1,
      :school_id => 1,
      :name => "MyString",
      :summary => "MyText"
    ).as_new_record)
  end

  it "renders new class_session form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", class_sessions_path, "post" do
      assert_select "input#class_session_room_id[name=?]", "class_session[room_id]"
      assert_select "input#class_session_teacher_id[name=?]", "class_session[teacher_id]"
      assert_select "input#class_session_school_id[name=?]", "class_session[school_id]"
      assert_select "input#class_session_name[name=?]", "class_session[name]"
      assert_select "textarea#class_session_summary[name=?]", "class_session[summary]"
    end
  end
end
