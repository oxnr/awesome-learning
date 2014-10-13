# Ruby on Rails

## Installation

### Install rbenv

rbenv is a new lightweight Ruby version management tool.
The established leader in the Ruby version management scene is RVM but rbenv is an interesting alternative if you want or need something significantly lighter with fewer features. Think of it as a bit like Sinatra and Rails.

```
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
```

### Install ruby

```
rbenv install 2.1.2
rbenv global 2.1.2
ruby -v
```

### Install Gems

```
gem install bundler
rbenv rehash
gem install sqlite3
gem install rails --version=4.0.2
rbenv rehash
```

### Generate a Rails App

```
rails new testapp
cd testapp
bin/rails server
```

### Application address

http://localhost:3000/
