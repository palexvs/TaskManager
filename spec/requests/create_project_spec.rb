require 'spec_helper'

describe "Create Project", :js => true do
  
  before do
    valid_signin()
  end
  
  subject { page }

  describe "Check index_page content" do
    it { should have_link('Add TODO List') }
  end

  describe "Check new_project_page content" do
    before { click_link "Add TODO List" }
    it { should have_selector('h3', text: 'New Project') }
  end

  describe "with valid project name" do
    let(:project_name) { 'First Project' }
    before do 
      click_link "Add TODO List" 
      fill_in "project_name", with: project_name
      click_button "Save"
    end

    it { should have_selector('div#main > table:first tr th p', text: project_name) }
  end

end
