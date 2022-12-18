class User < ApplicationRecord
  before_destroy :admin_not_delete
  before_update :admin_not_update
  has_many :tasks, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }
  private

  def admin_not_delete
    throw(:abort) if User.where(admin: true).count == 1 && self.admin == true
  end

  def admin_not_update
    throw(:abort) if User.where(admin: true).count == 1 && will_save_change_to_attribute?(:admin, to: false)
  end
end
