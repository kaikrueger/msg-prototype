Install:

### Packages / Dependencies

Make sure you have the right version of Git installed

```bash
# Install Git
sudo apt-get install -y git-core

# Make sure Git is version 1.7.10 or higher, for example 1.7.12 or 2.0.0
git --version
```

### Ruby

The use of ruby version managers such as RVM, rbenv or chruby with GitLab in production frequently leads to hard to diagnose problems. For example, GitLab Shell is called from OpenSSH and having a version manager can prevent pushing and pulling over SSH. Version managers are not supported and we strongly advise everyone to follow the instructions below to use a system ruby.

Remove the old Ruby 1.8 if present

```bash
sudo apt-get remove ruby1.8
```

Download Ruby and compile it:

```bash
mkdir /tmp/ruby && cd /tmp/ruby
curl -L --progress ftp://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz | tar xz
cd ruby-2.1.2
./configure --disable-install-rdoc
make
sudo make install
```

Install the Bundler Gem:

```bash
sudo gem install bundler --no-ri --no-rdoc
```

### System Users

Create a git user for GitLab:

```bash
sudo adduser --disabled-login --gecos 'MSG Rails' rails
```

###  Database

```bash
# Install the database packages
sudo apt-get install -y postgresql postgresql-client libpq-dev

# Login to PostgreSQL
sudo -u postgres psql -d template1
```

### Redis

```bash
sudo apt-get install redis-server

# Configure redis to use sockets
sudo cp /etc/redis/redis.conf /etc/redis/redis.conf.orig

# Disable Redis listening on TCP by setting 'port' to 0
sed 's/^port .*/port 0/' /etc/redis/redis.conf.orig | sudo tee /etc/redis/redis.conf

# Enable Redis socket for default Debian / Ubuntu path
echo 'unixsocket /var/run/redis/redis.sock' | sudo tee -a /etc/redis/redis.conf

# Activate the changes to redis.conf
sudo service redis-server restart

# Add git to the redis group
sudo usermod -aG redis git
```


### Install the application

```bash
# create the directory
sudo mkdir -p /var/www/playground

# set the owner of the directory
sudo chown rails.rails /var/www/playground
```

Clone the Source

```bash
cd /var/www/playground
sudo -u rails -H git clone https://github.com/wagnerag/msg-prototype.git .
sudo -u rails -H git checkout kk-dev
```

 Configure It

```bash
# fix the ruby version
# replace ruby '1.9.3' by ruby '2.1.2'
sudo -u rails -H vi Gemfile

#
sudo -u rails -H cp -i config/database.yml.example config/database.yml
sudo -u rails -H vi config/database.yml
```

Install Gems

```bash
sudo -u -rails -H bundle install --deployment 
```

 Initialize Database 

```bash
sudo -u rails -H bundle exec rake db:setup
sudo -u rails -H bundle exec rake db:seed
sudo -u rails -H bundle exec rake db:migrate RAILS_ENV=test
```


 Install Init Script

```bash
sudo cp lib/support/init.d/rails /etc/init.d/rails
sudo chmod 755 /etc/init.d/rails
```

Make GitLab start on boot:

```bash
sudo update-rc.d rails defaults 21
```

 Setup Logrotate

sudo cp lib/support/logrotate/gitlab /etc/logrotate.d/gitlab


### logging

```bash
sudo -u rails -H rm -rf log
sudo -u rails -H mkdir /tmp/rails
sudo -u rails -H ln -s /tmp/rails log
```

testing DB

```bash
sudo -u rails -H bundle exec rspec spec/
```

 Start Your MSG-Instance Instance

```bash
sudo service rails start
# or
sudo /etc/init.d/rails restart
```


### Automated test values

cp ~rails/test-playground.sh /opt/sbin/
chmod 755 /opt/sbin/test-playground.sh
crontab -e
*/1 *  *   *   *     /opt/sbin/test-playground.sh > /dev/null


