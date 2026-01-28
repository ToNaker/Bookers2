require 'rails_helper'

RSpec.describe '[STEP1] ユーザログイン前のテスト', type: :system do
  describe 'トップページのテスト' do
    before do
      visit root_path
    end

    it 'トップページのURLが正しい' do
      expect(current_path).to eq '/'
    end

    it 'welcome to Bookers が表示される' do
      expect(page).to have_content 'welcome to'
      expect(page).to have_content 'Bookers'
    end

    it 'Log inリンクが表示される' do
      expect(page).to have_link 'Log in'
    end

    it 'Sign upリンクが表示される' do
      expect(page).to have_link 'Sign up'
    end
  end

  describe 'アバウトページのテスト' do
    before do
      visit '/home/about'
    end

    it 'アバウトページのURLが正しい' do
      expect(current_path).to eq '/home/about'
    end
  end

  describe 'ログイン画面のテスト' do
    before do
      visit new_user_session_path
    end

    it 'ログイン画面のURLが正しい' do
      expect(current_path).to eq new_user_session_path
    end

    it 'Log in と表示される' do
      expect(page).to have_content 'Log in'
    end
  end

  describe '新規登録画面のテスト' do
    before do
      visit new_user_registration_path
    end

    it '新規登録画面のURLが正しい' do
      expect(current_path).to eq new_user_registration_path
    end

    it 'Sign up と表示される' do
      expect(page).to have_content 'Sign up'
    end
  end
end
