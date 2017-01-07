class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :groups, through: :users_groups
  has_many :users_groups
  has_many :messages

  validates :name, :email, presence: true

  def self.list_user(name, current_user)
    where('name LIKE(?)', "#{name}%").where.not(id: current_user.id)
  end

end
