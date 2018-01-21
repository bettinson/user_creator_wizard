class User < ApplicationRecord
  validates :name, :email, :age, :height, :color, presence: true
end
