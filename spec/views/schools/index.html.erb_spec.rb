require 'spec_helper'

describe "schools/index" do
  before(:each) do
    assign(:schools, [
      stub_model(School,
        :headmaster_id => 1,
        :name => "Name",
        :summary => "Summary",
        :student_count => 2
      ),
      stub_model(School,
        :headmaster_id => 1,
        :name => "Name",
        :summary => "Summary",
        :student_count => 2
      )
    ])
  end

  it "renders a list of schools" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Summary".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
