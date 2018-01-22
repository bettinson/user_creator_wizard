module UserValidations
  def self.validate_name(params)
    params[:first_name] != "" && params[:last_name] != ""
  end
  
  def self.validate_email(params)
    !!(params[:email] =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
  end

  def self.validate_details(params)
    return false unless valid_ages.include?(params[:age]) 
    return false unless is_number?(params[:height_feet])
    return false unless is_number?(params[:height_inches])
    return true if params[:weight] == ""
    return false unless is_number?(params[:weight])
    true
  end

  def self.validate_color(params)
    return false unless valid_colors.include?(params[:color])
    true
  end

  def self.valid_colors
    @colors ||= ['Red', 'Orange', 'Yellow', 'Green', 'Blue', 'Purple', 'Other']
  end

  def self.valid_ages
    @heights ||= ['17 or younger', '18 - 25', '26 - 35', '36 - 45', '46 or older']
  end

  private

  def self.is_number?(str) 
    !!(str =~ /\A[-+]?\d+\z/)
  end
end
