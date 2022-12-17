require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクの名前が空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(task_name: '', task_content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの内容が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(task_name: '失敗テスト', task_content:'' )
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(task_name: '成功', task_content: '成功')
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:second_task)}
    let!(:task3){FactoryBot.create(:third_task)}
    let!(:task4){FactoryBot.create(:forth_task)}
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.name_search('タスクネーム１')).to include(task)
        expect(Task.name_search('タスクネーム１')).not_to include(second_task)
        expect(Task.name_search('タスクネーム１').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.where(status: '完了')).to include(task)
        expect(Task.where(status: '完了')).not_to include(second_task)
        expect(Task.where(status: '完了').count).to eq 2
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.name_search('タスクネーム１').where(status: '完了')).to include(task)
        expect(Task.name_search('タスクネーム１').where(status: '完了')).not_to include(second_task)
        expect(Task.name_search('タスクネーム１').where(status: '完了').count).to eq 1
      end
    end
  end
end