FactoryBot.define do
  factory :task do
    task_name { 'タスクネーム１' }
    task_content { 'タスク内容１' }
  end

  factory :second_task, class: Task do
    task_name { 'タスクネーム２' }
    task_content { 'タスク内容２' }
  end
end
