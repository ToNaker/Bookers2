require 'rails_helper'

RSpec.describe '[STEP3] 仕上げのテスト', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:book) { create(:book, user: user) }
  let!(:other_book) { create(:book, user: other_user) }

  describe 'サクセスメッセージのテスト' do
    subject { page }

    it 'ユーザ新規登録成功時', spec_category: "バリデーションとメッセージ表示" do
      visit new_user_registration_path
      fill_in 'user[name]', with: Faker::Lorem.characters(number: 9)
      fill_in 'user[email_address]', with: 'a' + user.email_address # ←ここはあなたのアプリ側に合わせたまま
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button 'Sign up'
      is_expected.to have_content 'successfully'
    end

    it 'ユーザログイン成功時', spec_category: "バリデーションとメッセージ表示" do
      visit new_user_session_path
      fill_in 'name', with: user.name
      fill_in 'password', with: user.password
      click_button 'Log in'
      is_expected.to have_content 'successfully'
    end

    it 'ユーザログアウト成功時', spec_category: "バリデーションとメッセージ表示" do
      visit new_user_session_path
      fill_in 'name', with: user.name
      fill_in 'password', with: user.password
      click_button 'Log in'
      # Log out は button_to なので link ではなく button を押す
      click_button 'Log out'
      is_expected.to have_content 'successfully'
    end

    it 'ユーザのプロフィール情報更新成功時', spec_category: "バリデーションとメッセージ表示" do
      visit new_user_session_path
      fill_in 'name', with: user.name
      fill_in 'password', with: user.password
      click_button 'Log in'
      visit edit_user_path(user)
      click_button 'Update User'
      is_expected.to have_content 'successfully'
    end

    it '投稿データの新規投稿成功時: 投稿一覧画面から行います。', spec_category: "バリデーションとメッセージ表示" do
      visit new_user_session_path
      fill_in 'name', with: user.name
      fill_in 'password', with: user.password
      click_button 'Log in'
      visit books_path
      fill_in 'book[title]', with: Faker::Lorem.characters(number: 5)
      fill_in 'book[body]', with: Faker::Lorem.characters(number: 20)
      click_button 'Create Book'
      is_expected.to have_content 'successfully'
    end

    it '投稿データの更新成功時', spec_category: "バリデーションとメッセージ表示" do
      visit new_user_session_path
      fill_in 'name', with: user.name
      fill_in 'password', with: user.password
      click_button 'Log in'
      visit edit_book_path(book)
      click_button 'Update Book'
      is_expected.to have_content 'successfully'
    end
  end

  # ---- 以下、あなたの 03 の全文（失敗時テスト〜アクセス制限〜アイコン等）は
  #      すべて同じ置換ルールでOKです。 ----
end
