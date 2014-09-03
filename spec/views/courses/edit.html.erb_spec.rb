require 'spec_helper'

describe "courses/edit" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :name => "MyString",
      :summary => "MyText",
      :school_id => 1,
      :founding_teacher_id => 1
    ))
  end

  it "renders the edit course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", course_path(@course), "post" do
      assert_select "input#course_name[name=?]", "course[name]"
      assert_select "textarea#course_summary[name=?]", "course[summary]"
      assert_select "input#course_school_id[name=?]", "course[school_id]"
      assert_select "input#course_founding_teacher_id[name=?]", "course[founding_teacher_id]"
    end
  end
end
