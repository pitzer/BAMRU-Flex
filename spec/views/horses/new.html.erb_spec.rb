require 'spec_helper'

describe "horses/new" do
  before(:each) do
    assign(:horse, stub_model(Horse,
      :name => "MyString",
      :age => "MyString"
    ).as_new_record)
  end

  it "renders new horse form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => horses_path, :method => "post" do
      assert_select "input#horse_name", :name => "horse[name]"
      assert_select "input#horse_age", :name => "horse[age]"
    end
  end
end
