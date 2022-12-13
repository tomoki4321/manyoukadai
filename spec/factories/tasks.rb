FactoryBot.define do
  factory :task do
    task_name { 'タスクネーム１' }
    task_content { 'タスクコンテンツ１' }
  end
  factory :second_task, class: Task do
    task_name { 'タスクネーム２' }
    task_content { 'タスクコンテンツ２' }
  end
end