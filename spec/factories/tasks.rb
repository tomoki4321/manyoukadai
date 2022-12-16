FactoryBot.define do
  factory :task do
    task_name { 'タスクネーム１' }
    task_content { 'タスク内容１' }
    limit {'2022/12/14'}
    status {'完了'}
  end

  factory :second_task, class: Task do
    task_name { 'タスクネーム２' }
    task_content { 'タスク内容２' }
    limit {'2022/12/15'}
    status {'未着手'}
  end

  factory :third_task, class: Task do
    task_name { 'タスクネーム３' }
    task_content { 'タスク内容３' }
    limit {'2022/12/16'}
    status {'着手中'}
  end

  factory :forth_task, class: Task do
    task_name { 'タスクネーム４' }
    task_content { 'タスク内容４' }
    limit {'2022/12/17'}
    status {'完了'}
  end
end
