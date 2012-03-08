require 'spec_helper'

describe "horses/show" do
  before(:each) do
    @horse = assign(:horse, stub_model(Horse,
      :name => "Name",
      :age => "Age"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Age/)
  end
end
