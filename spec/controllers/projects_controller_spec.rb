require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do
	before(:each) do
    	@user = FactoryGirl.create(:user)
    	@project = FactoryGirl.create(:project,:user_id => @user.id)
    	session[:user_id] = @user.id
  	end  
#Harini - Archana
	describe 'New project' do
	    it 'should render the correct template' do
			get :new, user_id: @user.id
	    	expect(response).to render_template 'new'
	    end
	    it 'should redirect to login if user is not logged in' do
	    	session[:user_id] = nil
	    	get :new, user_id: @user.id
	    	expect(response).to redirect_to login_path
	    end
	end
#Harini - Prabhakar
	describe 'Create project' do
		it 'should create a project' do
			project_params = FactoryGirl.attributes_for(:project, :user_id => @user.id)
			expect { post :create, user_id: @user.id, :project => project_params}.to change(Project, :count).by(1)
		end
		it 'should redirect to the new project' do
			project_params = FactoryGirl.attributes_for(:project, :user_id => @user.id)
			post :create, user_id: @user.id, :project => project_params
			expect(response).to redirect_to "/users/#{@user.id}/projects/#{Project.last.id}"
		end
		it 'should not create if data is invalid' do
			project_params = FactoryGirl.attributes_for(:invalid_project, :user_id => @user.id)
			expect { post :create, user_id: @user.id, :project => project_params}.not_to change(Project, :count)
		end
		it 're-renders the new method if data is invalid' do
			project_params = FactoryGirl.attributes_for(:invalid_project, :user_id => @user.id)
			post :create, user_id: @user.id, :project => project_params
			expect(response).to render_template 'new'
		end
	end
#Rajvi - Jiten
	describe 'Destroy project' do
		it 'deletes the project' do
			expect{ delete :destroy, user_id: @user.id, id: @project }.to change(Project,:count).by(-1)
		end
		it 'redirects back to dashboard' do
			delete :destroy, user_id: @user.id, id: @project
			expect(response).to redirect_to dashboard_path
		end
	end
#Harini - Prabhakar
	describe 'Show project' do
		it 'renders the correct template' do
			get :show, user_id: @user.id, id: @project
			expect(response).to render_template 'show'
		end
	end
#Harini
	describe 'Edit project' do
		it 'locates the requested @project' do
			put :update, user_id: @user.id, id: @project, project: FactoryGirl.attributes_for(:project,user_id: @user.id)
			expect(assigns(:project)).to eq(@project)
		end
		it 'redirects to the updated project' do
			put :update, user_id: @user.id, id: @project, project: FactoryGirl.attributes_for(:project, user_id: @user.id)
			expect(response).to redirect_to "/users/#{@user.id}/projects/#{@project.id}"
		end
	end
#Rajvi - Jinee - Jiten
	describe 'Finish project' do
		it 'locates the requested @project' do
			get :finish, user_id: @user.id, id: @project, project: FactoryGirl.attributes_for(:project,user_id: @user.id)
			expect(assigns(:project)).to eq(@project)
		end
		it 'redirects to the dashboard' do
			get :finish, user_id: @user.id, id: @project, project: FactoryGirl.attributes_for(:project, user_id: @user.id)
			expect(response).to redirect_to "/dashboard"
		end
	end

end