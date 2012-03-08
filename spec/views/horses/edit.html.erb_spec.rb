require 'spec_helper'

describe "horses/edit" do
  before(:each) do
    @horse = assign(:horse, stub_model(Horse,
      :name => "MyString",
      :age => "MyString"
    ))
  end

  it "renders the edit horse form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => horses_path(@horse), :method => "post" do
      assert_select "input#horse_name", :name => "horse[name]"
      assert_select "input#horse_age", :name => "horse[age]"
    end
  end
end
