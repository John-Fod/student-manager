require 'spec_helper'

describe "rooms/new" do
  before(:each) do
    assign(:room, stub_model(Room,
      :name => "MyString",
      :summary => "MyText",
      :school_id => 1,
      :founding_teacher_id => 1
    ).as_new_record)
  end

  it "renders new room form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", rooms_path, "post" do
      assert_select "input#room_name[name=?]", "room[name]"
      assert_select "textarea#room_summary[name=?]", "room[summary]"
      assert_select "input#room_school_id[name=?]", "room[school_id]"
      assert_select "input#room_founding_teacher_id[name=?]", "room[founding_teacher_id]"
    end
  end
end
