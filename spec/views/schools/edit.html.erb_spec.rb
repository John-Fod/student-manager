require 'spec_helper'

describe "schools/edit" do
  before(:each) do
    @school = assign(:school, stub_model(School,
      :headmaster_id => 1,
      :name => "MyString",
      :summary => "MyString",
      :student_count => 1
    ))
  end

  it "renders the edit school form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", school_path(@school), "post" do
      assert_select "input#school_headmaster_id[name=?]", "school[headmaster_id]"
      assert_select "input#school_name[name=?]", "school[name]"
      assert_select "input#school_summary[name=?]", "school[summary]"
      assert_select "input#school_student_count[name=?]", "school[student_count]"
    end
  end
end
