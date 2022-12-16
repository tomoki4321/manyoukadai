FactoryBot.define do
  factory :task do
    task_name { 'タスクネーム１' }
    task_content { 'タスク内容１' }
    limit {'2022/12/15'}
    status {'完了'}
  end

  factory :second_task, class: Task do
    task_name { 'タスクネーム２' }
    task_content { 'タスク内容２' }
    limit {'2022/12/14'}
    status {'未着手'}
  end
end
