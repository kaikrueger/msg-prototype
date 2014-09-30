Install:

### 7. Start application
```bash
sudo mkdir -p /var/www/playground
sudo chown rails.rails /var/www/playground
cd /var/www/playground
sudo -u rails -H git clone https://github.com/wagnerag/msg-prototype.git .
sudo -u rails -H checkout kk-dev
sudo -u rails -H vi Gemfile
```
replace ruby '1.9.3' by ruby '2.1.2'

```bash
sudo bundle install
sudo cp lib/support/init.d/rails /etc/init.d/rails
sudo chmod 755 /etc/init.d/rails
```

```bash
sudo -u rails -H bundle exec rake db:migrate RAILS_ENV=test
```

cp ~rails/test-playground.sh /opt/sbin/
chmod 755 /opt/sbin/test-playground.sh
crontab -e
*/1 *  *   *   *     /opt/sbin/test-playground.sh > /dev/null


### 7. Start application

    sudo service rails start
    sudo service nginx restart

