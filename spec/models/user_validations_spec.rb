require 'rails_helper'

RSpec.describe UserValidations, :type => :model do
  params = {}
  context 'user validation' do
    context 'name' do 
      it 'validates a correct name' do
        params[:first_name] = 'Matt'
        params[:last_name] = 'Bettinson'
        expect(UserValidations.validate_name(params)).to be(true)
      end

      it 'invalidates an incorrect name' do
        params[:first_name] = ''
        params[:last_name] = 'Bettinson'
        expect(UserValidations.validate_name(params)).to_not be(true)

        params[:first_name] = 'Matt'
        params[:last_name] = ''
        expect(UserValidations.validate_name(params)).to_not be(true)

        params[:first_name] = ''
        params[:last_name] = ''
        expect(UserValidations.validate_name(params)).to_not be(true)
      end
    end

    context 'email' do
      it 'validates a correct email' do
        params[:email] = 'mattbettinson@gmail.com'
        expect(UserValidations.validate_email(params)).to be(true)
      end
      it 'invalidates an  incorrect email' do
        params[:email] = 'fourteen'
        expect(UserValidations.validate_email(params)).to_not be(true)
      end
    end

    context 'details' do 
      it 'validates correct age, height, weight' do
        params[:age] = '18 - 25'
        params[:height_feet] = '5'
        params[:height_inches] = '11'
        params[:weight] = ''
        expect(UserValidations.validate_details(params)).to be(true)
      end

      it 'invalidates when not all details are correct' do
        params[:age] = '18 - 25'
        params[:height_feet] = '5'
        params[:height_inches] = 'eleven'
        params[:weight] = ''
        expect(UserValidations.validate_details(params)).to_not be(true)
      end

      it 'validates weight correctly' do
        params[:age] = '18 - 25'
        params[:height_feet] = '5'
        params[:height_inches] = '11'
        params[:weight] = 'jeffrey'
        expect(UserValidations.validate_details(params)).to_not be(true)
        params[:weight] = '150'
        expect(UserValidations.validate_details(params)).to be(true)
      end
    end
    context 'colors' do 
      it 'validates correct color' do
        params[:color] = 'Blue'
        expect(UserValidations.validate_color(params)).to be(true)
      end

      it 'invalidates an incorrect color' do
        params[:color] = 'Elephant'
        expect(UserValidations.validate_color(params)).to_not be(true)
      end
    end
  end
end
