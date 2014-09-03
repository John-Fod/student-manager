require 'spec_helper'

describe "rooms/edit" do
  before(:each) do
    @room = assign(:room, stub_model(Room,
      :name => "MyString",
      :summary => "MyText",
      :school_id => 1,
      :founding_teacher_id => 1
    ))
  end

  it "renders the edit room form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", room_path(@room), "post" do
      assert_select "input#room_name[name=?]", "room[name]"
      assert_select "textarea#room_summary[name=?]", "room[summary]"
      assert_select "input#room_school_id[name=?]", "room[school_id]"
      assert_select "input#room_founding_teacher_id[name=?]", "room[founding_teacher_id]"
    end
  end
end
