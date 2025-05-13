class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def has_stock?(ticker)
    stocks.where(ticker: ticker).exists?
  end

  def under_stock_limit?
    stocks.count < 5
  end

  def can_add_stock?(ticker)
    under_stock_limit? && !has_stock?(ticker)
  end

  def full_name
    return "#{first_name} #{last_name}" unless first_name.to_s.empty? && last_name.to_s.empty?
    "Anonymous"
  end

  def self.lookup(param)
    param.strip!
    (first_name_lookup(param) + last_name_lookup(param) + email_lookup(param)).uniq
  end

  def friends?(id)
    self.friends.where(id: id).exists?
  end

  class << self
    private

    def first_name_lookup(param)
      where("first_name like ?", "%#{param}%")
    end

    def last_name_lookup(param)
      where("last_name like ?", "%#{param}%")
    end

    def email_lookup(param)
      where("email like ?", "%#{param}%")
    end
  end
end
