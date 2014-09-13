require 'spec_helper'

describe "class_sessions/edit" do
  before(:each) do
    @class_session = assign(:class_session, stub_model(ClassSession,
      :room_id => 1,
      :teacher_id => 1,
      :school_id => 1,
      :name => "MyString",
      :summary => "MyText"
    ))
  end

  it "renders the edit class_session form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", class_session_path(@class_session), "post" do
      assert_select "input#class_session_room_id[name=?]", "class_session[room_id]"
      assert_select "input#class_session_teacher_id[name=?]", "class_session[teacher_id]"
      assert_select "input#class_session_school_id[name=?]", "class_session[school_id]"
      assert_select "input#class_session_name[name=?]", "class_session[name]"
      assert_select "textarea#class_session_summary[name=?]", "class_session[summary]"
    end
  end
end
