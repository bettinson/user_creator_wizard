module UserCreationHelper
  def current_step
    session[:current_step] ? session[:current_step].to_sym : :name
  end
end
