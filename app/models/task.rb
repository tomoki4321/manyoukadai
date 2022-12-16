class Task < ApplicationRecord
  validates :task_name,presence: true,length:{in:1..140}
  validates :task_content,presence: true,length:{in:1..140}

  scope :recent_order, -> {order(created_at: :desc)}
  scope :limit_order_desc, -> {order(limit: :desc)}
  scope :limit_order_asc, -> {order(limit: :asc)}

  def self.name_search(search)
    where("task_name LIKE ?", "%#{search}%")
  end

end
