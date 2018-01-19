module UserValidations
  def self.validate_name(params)
    params[:first_name] != "" && params[:last_name] != ""
  end
  
  def self.validate_email(params)
    params[:email] =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  end

  def self.validate_details(params)
    valid_heights.include?(params[:height]) 
  end

  def self.valid_heights
    @heights ||= ['17 or younger', '18 - 25', '26 - 35', '36 - 45', '46 or older']
  end
end
