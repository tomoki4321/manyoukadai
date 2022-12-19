class Task < ApplicationRecord
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  validates :task_name,presence: true,length:{in:1..140}
  validates :task_content,presence: true,length:{in:1..140}

  enum priority:{
    低: 1,
    中: 2,
    高: 3
  }


  scope :recent_order, -> {order(created_at: :desc)}
  scope :limit_order_desc, -> {order(limit: :desc)}
  scope :limit_order_asc, -> {order(limit: :asc)}
  scope :priority_order_desc, -> {order(priority: :desc)}
  scope :priority_order_asc, -> {order(priority: :asc)}

  def self.name_search(search)
    where("task_name LIKE ?", "%#{search}%")
  end

end
