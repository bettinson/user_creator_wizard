class UserCreationController < ApplicationController
  include Wicked::Wizard
  steps :name, :email, :details, :color, :finish

  def show
    render_wizard
  end

  def update
    session[:user] ||= {}
    session[:current_step] = step
    case step
    when :email
      unless UserValidations.validate_name(params)
        redirect_to(wizard_path(:name), alert: 'Invalid name')
        return
      end
      session[:user][:name] = "#{params[:first_name]} #{params[:last_name]}"
    when :details
      unless UserValidations.validate_email(params)
        redirect_to(wizard_path(:email), alert: 'Invalid email')
        return
      end
      session[:user][:email] = params[:email]
    when :color
      unless UserValidations.validate_details(params)
        redirect_to(wizard_path(:details), alert: 'Invalid details')
        return
      end
      session[:user][:weight] = params[:weight]
      session[:user][:height] = "#{params[:height_feet]} '#{params[:height_inches]}"
      session[:user][:age] = params[:age]
    when :finish
      if params[:color] == 'Other'
        session[:user][:color] = params[:other]
      end
      unless UserValidations.validate_color(params)
        redirect_to(wizard_path(:color), alert: 'Invalid color')
        return
      end
      session[:user][:color] = params[:color] unless params[:color] == 'Other'
      user_hash = session[:user].select { |key, value| permitted.include? key.to_s }
      @user = User.new(user_hash)
      unless @user.save!
        redirect_to(wizard_path(:name), alert: 'Invalid input.') 
      end
      session[:current_step] = 'completed'
    end
    render_wizard
  end

  private

  def permitted
    @permitted ||= %w(name email age height weight color)
      .inject([]){ |c, i| c << i}
  end
end
