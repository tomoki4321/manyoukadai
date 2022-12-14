class Task < ApplicationRecord
  validates :task_name,presence: true,length:{in:1..140}
  validates :task_content,presence: true,length:{in:1..140}
end
