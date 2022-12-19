require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user){FactoryBot.create(:user)}
  let!(:task){FactoryBot.create(:task, user: user)}
  let!(:task2){FactoryBot.create(:second_task, user: user)}
  let!(:task3){FactoryBot.create(:third_task, user: user)}
  let!(:task4){FactoryBot.create(:forth_task, user: user)}
  let!(:label){FactoryBot.create(:label)}
  let!(:label2){FactoryBot.create(:second_label)}
  let!(:label3){FactoryBot.create(:third_label)}
  let!(:labelling){FactoryBot.create(:labelling, task: task2, label: label2)}

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit tasks_path
        expect(page).to have_content 'タスクネーム１'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit tasks_path
        task_list = all('.task_all')
        expect(task_list.first).to have_content 'タスクネーム４'
      end
    end
    context 'タスクが終了期限の昇順に並んでいる場合' do
      it '終了期限が早いタスクが一番上に表示される' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        @task1 = task
        @task2 = task2
        visit tasks_path
        find("#task_limit_select").find("option[value='昇順']").select_option
        click_button "検索"
        task_list = all('.task_all')
        expect(task_list.first).to have_content 'タスクネーム１'
      end
    end
    context 'タスクが優先順位の降順に並んでいる場合' do
      it '優先順位が高いタスクが一番上に表示される' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit tasks_path
        find("#task_priority").find("option[value='優先▼']").select_option
        click_button "検索"
        task_list = all('.task_all')
        expect(task_list.first).to have_content 'タスクネーム１'
      end
    end
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        date = Date.new(2022,12,15)
        visit new_task_path
        fill_in 'task[task_name]', with: 'テスト１'
        fill_in 'task[task_content]', with: 'テスト２'
        fill_in "task[limit]", with: date
        find("#task_status").find("option[value='完了']").select_option
        check 'label1'
        click_button "タスク作成"
        expect(page).to have_content 'テスト１'
        expect(page).to have_content 'label1'
      end
    end
  end
  describe '編集機能' do
    context 'タスクを編集した場合' do
      it '詳細で編集したタスクが表示される' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        date = Date.new(2021,10,17)
        visit edit_task_path(task2)
        fill_in "task[task_name]", with: task.task_name
        fill_in "task[task_content]", with: task.task_content
        fill_in "task[limit]", with: date
        find("#task_status").find("option[value='完了']").select_option
        find("#task_priority").find("option[value='高']").select_option
        uncheck 'label2'
        check 'label1'
        click_button "タスク作成"
        visit task_path(task2)
        expect(page).to have_content 'label1'
        expect(page).not_to have_content 'label2'
      end
    end
  end

  describe '詳細表示機能' do
    context 'タスク詳細画面に遷移した場合' do
      it 'タスクの内容が表示される' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        task2
        visit task_path(task2)
        expect(page).to have_content 'タスクネーム２'
      end
    end

    context 'タスク詳細画面に遷移した場合' do
      it 'タスクのラベルが表示される' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit tasks_path
        visit task_path(task2)
        expect(page).to have_content 'label2'
      end
    end
  end
  describe '検索機能' do
    context 'タイトル検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit tasks_path
        fill_in 'task[task_name]', with: 'タスクネーム１'
        click_button "検索"
        expect(page).to have_content 'タスクネーム１'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit tasks_path
        find("#task_status").find("option[value='完了']").select_option
        click_button "検索"
        expect(page).to have_content 'タスクネーム１'
      end
    end
    context 'タイトル検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit tasks_path
        fill_in 'task[task_name]', with: 'タスクネーム１'
        find("#task_status").find("option[value='完了']").select_option
        click_button "検索"
        expect(page).to have_content 'タスクネーム１'
      end
    end
    context 'ラベル検索をした場合' do
      it "指定ラベルを含むタスクが絞り込まれる" do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit tasks_path
        select 'label2', from: 'task_label_id'
        click_button "検索"
        expect(page).to have_content 'label2'
      end
    end
  end
end