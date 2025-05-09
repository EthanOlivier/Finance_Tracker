class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
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
end
