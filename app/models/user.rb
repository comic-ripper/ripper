class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_paper_trail ignore: [:last_sign_in_at, :last_sign_in_ip, :current_sign_in_at, :current_sign_in_ip, :sign_in_count, :updated_at]
end
