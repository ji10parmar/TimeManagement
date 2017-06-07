require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
	before(:each) do
    	@user = FactoryGirl.create(:user)
  	end
#Jing
	describe 'Register' do
	    it 'should render the correct template' do
			get :new
	    	expect(response).to render_template('new')
	    end
	end
#Jinee
	describe 'render the index template' do
		it 'should redirect to home' do
			get :index
			expect(response).to redirect_to login_path
		end
	end	
end