require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path
        expect(page).to have_content 'タスクネーム１'
      end
    end
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[task_name]', with: 'updated_1'
        fill_in 'task[task_content]', with: 'updated_2'
        click_button "タスク作成"
        expect(page).to have_content 'updated_1'
      end
    end
  end
  describe '詳細表示機能' do
    context 'タスク詳細画面に遷移した場合' do
      it 'タスクの内容が表示される' do
      task = FactoryBot.create(:second_task)
      visit task_path(task)
      expect(page).to have_content 'タスクネーム２'
      end
    end
  end
end