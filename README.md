<h1>User</h1>
<table>
  <tr>
    <th>name</th>
    <td>string<td>
  </tr>
  <tr>
    <th>email</th>
    <td>string<td>
  </tr>
  <tr>
    <th>password_digest</th>
    <td>string<td>
  </tr>
</table>
<h1>Task</h1>
<table>
  <tr>
    <th>user_id</th>
    <td>references<td>
  </tr>
  <tr>
    <th>task_name</th>
    <td>string<td>
  </tr>
  <tr>
    <th>task_content</th>
    <td>string<td>
  </tr>
  <tr>
    <th>status</th>
    <td>string<td>
  </tr>
  <tr>
    <th>limit</th>
    <td>date<td>
  </tr>
  <tr>
    <th>priority</th>
    <td>integer<td>
  </tr>
</table>
<h1>Label</h1>
<table>
  <tr>
    <th>task_id</th>
    <td>references<td>
  </tr>
  <tr>
    <th>label_name</th>
    <td>string<td>
  </tr>
</table>

Herokuへのデプロイ手順
・ruby3 系を使用している場合以下を gem に記述して
bundle　install
  gem 'net-smtp'
  gem 'net-imap'
  gem 'net-pop'

　heroku login
　heroku create
　git add .
　git commit -m 'メッセージ'

・Heroku buildpackを追加する
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs

・Failed to install gems via Bundler.のエラー対応
  bundle lock --add-platform x86_64-linux
  ※再度git addから行う
・You are trying to install ruby-3.0.1 on heroku-22.のエラー対応
  heroku stack
  以下のコマンドで、デフォルトのheroku-22からheroku-20へstackを切り替える
  heroku stack:set heroku-20
・Precompiling assets failed.のエラー対応
  以下のコマンドをjsonファイルに追記し、node.jsのバージョンを安定版の１６に変更
  "engines": {
    "node": "16.x"
  }
・Githubとの連携
  heroku上の のアプリケーションを選択し「deploy」のタブを選択
  Githubを選択肢し、masterブランチを選択、connect。
