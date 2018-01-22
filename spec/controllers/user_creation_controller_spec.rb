require 'rails_helper'

RSpec.describe UserCreationController, :type => :controller do
  context 'user creation' do 
    it 'creates a user with correct input' do 
      get :index
      expect do
        put :update, params: {id: 'email', first_name: 'Matt', last_name: 'Bettinson'}
        put :update, params: {id: 'details', email: 'mattbettinson@gmail.com'}
        put :update, params: {id: 'color', weight: '150.2', 
          height_feet: '5', height_inches: '11', age: '18 - 25'}
        put :update, params: {id: 'finish', color: 'Blue'}
      end.to change { User.count }
    end

    it "doesen't creates a user and throws error with incorrect input" do 
      expect do
        put :update, params: {id: 'email', first_name: '', last_name: 'Bettinson'}
        put :update, params: {id: 'details', email: 'mattbettinson@gmail.com'}
        put :update, params: {id: 'color', weight: '150', 
          height_feet: '5', height_inches: '11', age: '18 - 25'}
        put :update, params: {id: 'finish', color: 'Blue'}
      end.to raise_error(ActiveRecord::RecordInvalid,"Validation failed: Name can't be blank")
    end

    it "doesen't create a user and throws error when color is other but not inputted" do 
      expect do
        put :update, params: {id: 'email', first_name: 'Matt', last_name: 'Bettinson'}
        put :update, params: {id: 'details', email: 'mattbettinson@gmail.com'}
        put :update, params: {id: 'color', weight: '150', 
          height_feet: '5', height_inches: '11', age: '18 - 25'}
        put :update, params: {id: 'finish', color: 'Other', other: ''}
      end.to_not change { User.count }
    end

    it "does create a user and throws error when color is other and inputted" do 
      expect do
        put :update, params: {id: 'email', first_name: 'Matt', last_name: 'Bettinson'}
        put :update, params: {id: 'details', email: 'mattbettinson@gmail.com'}
        put :update, params: {id: 'color', weight: '150', 
          height_feet: '5', height_inches: '11', age: '18 - 25'}
        put :update, params: {id: 'finish', color: 'Other', other: 'Turquoise'}
      end.to change { User.count }
    end
  end
end