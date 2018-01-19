class UserCreationController < ApplicationController
  include Wicked::Wizard
  steps :name, :email, :details, :color, :finish

  def show
    render_wizard
  end

  def update
    session[:user] ||= {}
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
      # session[:user][:details] = params[:email]
    when :color
      unless UserValidations.validate_details(params)
        redirect_to(wizard_path(:details), alert: 'Invalid details')
        return
      end
    when :finish
      unless UserValidations.validate_color(params)
        redirect_to(wizard_path(:color), alert: 'Invalid color')
        return
      end
      @user = User.new(session[:user])
      @user.save!
    end
    render_wizard
  end

  private

  def permitted
    @permitted ||= %w(first_name last_name email age height weight color)
      .inject([]){ |c, i| c << i.to_sym }
  end
end
