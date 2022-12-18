require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  let!(:user){FactoryBot.create(:user)}
  let!(:admin_user){FactoryBot.create(:admin_user)}

  describe 'ユーザー登録機能' do
    context 'ユーザーを新規登録した場合' do
      it 'ログインした状態でルートパス（タスク一覧）に移動出来る' do
        visit new_user_path
        fill_in 'user[name]', with: 'tomoki'
        fill_in 'user[email]', with: 'tomoki@gmail.com'
        fill_in 'user[password]', with: 'tomoki'
        fill_in 'user[password_confirmation]', with: 'tomoki'
        click_button "Create my account"
        visit root_path
        expect(current_path).to eq root_path
      end
    end

    context 'ログインせずタスク一覧にアクセスした場合' do
      it 'ログイン画面に遷移する' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'セッション機能' do
    context 'ログインをした場合' do
      it 'ルートパス（タスク一覧）に移動出来る' do
        visit new_session_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password
        click_button "Log in"
        visit root_path
        expect(current_path).to eq root_path
      end
    end

    context 'ログインをした場合' do
      it '自分の詳細ページに移動出来る' do
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button "ログイン"
        visit user_path(user)
        expect(current_path).to eq user_path(user)
      end
    end

    context 'ログアウトをした場合' do
      it 'ログイン画面に戻る' do
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button "ログイン"
        visit user_path(user)
        click_link "ログアウト"
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe '管理画面機能' do
    context '管理ユーザーがログインした状態で管理画面に移動した場合' do
      it '管理画面に移動出来る' do
        visit new_session_path
        fill_in 'session_email', with: admin_user.email
        fill_in 'session_password', with: admin_user.password
        click_button "ログイン"
        visit admin_users_path
        expect(current_path).to eq admin_users_path
      end
    end

    context '一般ユーザーがログインした状態で管理画面に移動した場合' do
      it '管理画面に移動出来ない' do
        visit new_session_path
        fill_in 'session_email', with: user.email
        fill_in 'session_password', with: user.password
        click_button "ログイン"
        visit admin_users_path
        expect(current_path).not_to eq admin_users_path
      end
    end

    context '管理ユーザーがユーザーの新規登録をした場合' do
      it 'ユーザーがユーザー一覧に表示される' do
        visit new_session_path
        fill_in 'session_email', with: admin_user.email
        fill_in 'session_password', with: admin_user.password
        click_button "ログイン"
        visit admin_users_path
        click_link 'user_create'
        fill_in 'user_name', with: 'tomoaki2'
        fill_in 'user_email', with: 'tomoaki@2.com'
        fill_in 'user_password', with: 'tomoaki'
        fill_in 'user_password_confirmation', with: 'tomoaki'
        select false, from: :user_admin
        click_button "登録する"
        visit admin_users_path
        expect(page).to have_content 'tomoaki@2.com'
      end
    end

    context '管理ユーザーはユーザーの詳細にアクセスをした場合' do
      it 'ユーザーの詳細画面が表示される' do
        visit new_session_path
        fill_in 'session_email', with: admin_user.email
        fill_in 'session_password', with: admin_user.password
        click_button "ログイン"
        visit admin_users_path
        visit admin_user_path(user)
        expect(current_path).to eq admin_user_path(user)
      end
    end

    context '管理ユーザーはユーザーの編集画面で名前と権限を編集した場合' do
      it 'ユーザーの詳細画面で変更後の名前が表示される' do
        visit new_session_path
        fill_in 'session_email', with: admin_user.email
        fill_in 'session_password', with: admin_user.password
        click_button "ログイン"
        visit admin_users_path
        visit edit_admin_user_path(user)
        fill_in 'user_name', with: 'user98'
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        fill_in 'user_password_confirmation', with: user.password
        select false, from: :user_admin
        click_button "更新する"
        visit admin_user_path(user)
        expect(page).to have_content "user98"
      end
    end

    context '管理ユーザーはユーザーを削除した場合' do
      it 'ユーザー一覧画面に表示されない' do
        visit new_session_path
        fill_in 'session_email', with: admin_user.email
        fill_in 'session_password', with: admin_user.password
        click_button "ログイン"
        visit admin_users_path
        page.accept_confirm {click_link 'user_destroy', href: admin_user_path(user)}
        visit admin_users_path
        expect(page).not_to have_content user.name
      end
    end
  end
end