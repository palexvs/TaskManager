require 'spec_helper'

describe "Project", :js => true do
  subject { page }

  before do
    valid_signin()
  end

  describe "Check 'Add TODO List' button" do
    it { should have_link('Add TODO List') }
  end

  describe "Create" do

    describe "Check modal window 'New Project'" do
      before { click_link "Add TODO List" }
      
      subject { find('#myModal') }

      it { page.should have_selector('#myModal') }
      it { should have_selector('h3', text: 'New Project') }
      it { should have_field('project_name',) }
      it { should have_button('Save') }
      it { should have_link('Cancel') }
    end

    describe "with valid project name" do
      let(:project_name) { "First Project" }
      before do 
        click_link "Add TODO List" 
        fill_in "project_name", with: project_name
        click_on "Save"
      end
      let(:project) { Project.find_by_name(project_name) }

      subject { find("#main table#project_#{project.id} tr:first") }

      it { page.should_not have_selector('#myModal') }
      it { should have_selector('th.name p', text: project.name) }
      it { find('th.control ul.nav').should_not be_visible }
      it { find('th.control ul.nav li:eq(1)').should have_link('', href: edit_project_path(project)) }
      it { find('th.control ul.nav li:eq(2)').should have_link('', href: project_path(project)) }
    end
  end

  describe "Delete" do
    let!(:project) { create(:project, user: @user) }
    before do
      visit root_path
      sleep(1)
      page.execute_script("$('table#project_#{project.id} th.control ul.nav').show()")
      find("table#project_#{project.id} tr th.control ul.nav li:eq(2)").find("a i[@class='icon-trash']").click
    end
    it "should be able to delete project" do
      page.driver.browser.switch_to.alert.accept
      should_not have_selector("div#main > table#project_#{project.id}")
    end
    it "should delete project from DB" do
      expect do 
        page.driver.browser.switch_to.alert.accept 
        sleep(1)
      end.to change(Project, :count).by(-1)
    end
  end

  describe "Index" do
    before do
      p1 = create(:project, name: "Project 1", user: @user)
      create(:task, name: "Task 1", project: p1)
      p2 = create(:project, name: "Project 2", user: @user)
      create(:task, name: "Task 2", project: p2)
    end
    it "should show projects/tasks list" do
      should have_selector("#main table", count:2)

      Project.includes(:task).all.each do |p|
        within("#main table#project_#{p.id}") do 
          should have_selector('tr:first th.name p', text: p.name)
          p.task.each do |t|
            should have_selector("tr##{p.id}-#{t.id} td.name p", text: t.name)
          end
        end
      end
    end
  end

end