Upgrade:

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

### Stop the service

```bash
sudo /etc/init.d/rails stop
```

### Update the application

Clone the Source

```bash
cd /var/www/playground
sudo -u rails -H rm -f log
sudo -u rails -H git fetch
sudo -u rails -H git pull
sudo -u rails -H git checkout master
```

 Configure It

```bash
# fix the ruby version
# replace ruby '1.9.3' by ruby '2.1.2'
sudo -u rails -H vi Gemfile

#
diff -cNrw config/database.yml.example config/database.yml
sudo -u rails -H cp -i config/database.yml.example config/database.yml
sudo -u rails -H vi config/database.yml
```

Install Gems

```bash
sudo -u rails -H bundle install --deployment 
```

```bash
sudo service postgresql start
```

 Initialize Database 

```bash
sudo -u rails -H bundle exec rake db:setup RAILS_ENV=production
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

sudo cp lib/support/logrotate/rails /etc/logrotate.d/rails


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

### check nginx configration


### Start Your MSG-Instance Instance

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


