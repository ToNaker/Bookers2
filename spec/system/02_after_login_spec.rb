require 'rails_helper'

RSpec.describe '[STEP2] ユーザログイン後のテスト', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:book) { create(:book, user: user) }
  let!(:other_book) { create(:book, user: other_user) }

  before do
    visit new_user_session_path
    fill_in 'name', with: user.name
    fill_in 'password', with: user.password
    click_button 'Log in'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
      subject { current_path }

      it 'Homeを押すと、自分のユーザ詳細画面に遷移する', spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
        home_link = find_all('a')[1].text
        home_link = home_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link home_link
        is_expected.to eq '/users/' + user.id.to_s
      end
      it 'Usersを押すと、ユーザ一覧画面に遷移する', spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
        users_link = find_all('a')[2].text
        users_link = users_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link users_link
        is_expected.to eq '/users'
      end
      it 'Booksを押すと、投稿一覧画面に遷移する', spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
        books_link = find_all('a')[3].text
        books_link = books_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link books_link
        is_expected.to eq '/books'
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit books_path
    end

    context '表示内容の確認' do
      it 'URLが正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(current_path).to eq '/books'
      end
      it '自分と他人の画像のリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(page).to have_link '', href: user_path(book.user)
        expect(page).to have_link '', href: user_path(other_book.user)
      end
      it '自分の投稿と他人の投稿のタイトルのリンク先がそれぞれ正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(page).to have_link book.title, href: book_path(book)
        expect(page).to have_link other_book.title, href: book_path(other_book)
      end
      it '自分の投稿と他人の投稿のオピニオンが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(page).to have_content book.body
        expect(page).to have_content other_book.body
      end
    end

    context 'サイドバーの確認' do
      it '自分の名前と紹介文が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(page).to have_content user.name
        expect(page).to have_content user.introduction
      end
      it '自分のユーザ編集画面へのリンクが存在する', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(page).to have_link '', href: edit_user_path(user)
      end
      it '「New book」と表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(page).to have_content 'New book'
      end
      it 'titleフォームが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(page).to have_field 'book[title]'
      end
      it 'titleフォームに値が入っていない', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(find_field('book[title]').text).to be_blank
      end
      it 'bodyフォームが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(page).to have_field 'book[body]'
      end
      it 'bodyフォームに値が入っていない', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(find_field('book[body]').text).to be_blank
      end
      it 'Create Bookボタンが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(page).to have_button 'Create Book'
      end
    end

    context '投稿成功のテスト' do
      before do
        fill_in 'book[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'book[body]', with: Faker::Lorem.characters(number: 20)
      end

      it '自分の新しい投稿が正しく保存される', spec_category: "CRUD機能に対するコントローラの処理と流れ(ログイン状況を意識した応用)" do
        expect { click_button 'Create Book' }.to change(user.books, :count).by(1)
      end
      it 'リダイレクト先が、保存できた投稿の詳細画面になっている', spec_category: "CRUD機能に対するコントローラの処理と流れ(ログイン状況を意識した応用)" do
        click_button 'Create Book'
        expect(current_path).to eq '/books/' + Book.last.id.to_s
      end
    end
  end

  # ---- ここから下、あなたの 02 の残り全文が続きます ----
  # （この後の内容は、貼ってくれた 02 の続きが途中で切れていない前提で、
  #  ルート修正は同様に不要です。）
end
