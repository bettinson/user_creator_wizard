class UserCreationController < ApplicationController
  include Wicked::Wizard
  steps :name, :email, :details, :color, :finish

  def show
    render_wizard
  end

  def update
    session[:user] ||= {}
    permitted.each { |p| session[:user][p] = params[p] if params[p] }

    case step
    when :finish
      @user = User.new(session[:user])
      @user.save!
    end
    render_wizard
  end

  private

  def permitted
    @permitted ||= %w(name email age height weight color).inject([]){ |c, i| c << i.to_sym }
  end
end
