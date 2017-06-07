require 'rails_helper'

RSpec.describe ShiftsController, :type => :controller do
	before(:each) do
    	@user = FactoryGirl.create(:user)
    	@project = FactoryGirl.create(:project,:user_id => @user.id)
    	@shift = FactoryGirl.create(:shift,:project_id => @project.id)
    	session[:user_id] = @user.id
  	end
#Rajvi - Prabhakar
	describe 'Create New Shift' do
		it 'should render the correct template' do
			get :new, user_id: @user.id, project_id: @project.id
	    	expect(response).to render_template 'new'
	    end
	    it 'should redirect to login if user is not logged in' do
	    	session[:user_id] = nil
	    	get :new, user_id: @user.id, project_id: @project.id
	    	expect(response).to redirect_to login_path
	    end
	end
#Rajvi - Prabhakar
	describe 'Create shift' do
		it 'should create a shift' do
			shift_params = FactoryGirl.attributes_for(:shift, :project_id => @project.id)
			expect { post :create, user_id: @user.id, project_id: @project.id, :shift => shift_params}.to change(Shift, :count).by(1)
		end
		it 'should redirect to the project page' do
			shift_params = FactoryGirl.attributes_for(:shift, :project_id => @project.id)
			post :create, user_id: @user.id, project_id: @project.id, :shift => shift_params
			expect(response).to redirect_to "/users/#{@user.id}/projects/#{@project.id}"
		end
	end
#Rajvi
	describe 'Destroy shift' do
		it 'deletes the shift' do
			expect{ delete :destroy, user_id: @user.id, project_id: @project.id, id: @shift }.to change(Shift,:count).by(-1)
		end
		it 'redirects back to project shifts' do
			delete :destroy, user_id: @user.id, project_id: @project.id, id: @shift
			expect(response).to redirect_to "/users/#{@user.id}/projects/#{@project.id}/shifts"
		end
	end

# Show shift is not necessary so its ommited
#Rajvi - Prabhakar
	describe 'Edit shift' do
		it 'locates the requested @shift' do
			put :update, user_id: @user.id, project_id: @project.id, id: @shift, shift: FactoryGirl.attributes_for(:shift,project_id: @project.id)
			expect(assigns(:shift)).to eq(@shift)
		end
		it 'redirects to the updated shifts list' do
			put :update, user_id: @user.id, project_id: @project.id, id: @shift, shift: FactoryGirl.attributes_for(:shift,project_id: @project.id)
			expect(response).to redirect_to "/users/#{@user.id}/projects/#{@project.id}/shifts"
		end
	end
end