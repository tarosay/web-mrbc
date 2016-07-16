# web-mrbc

Web compiler for mruby.

## deployment

How to build and deploy.

```
# rails webApp
$ git clone --depth=1 https://github.com/tarosay/web-mrbc.git
$ cd web-mrbc/wakayamarb
$ bundle install --path=vendor/bundle
$ bundle exec rake db:migrate


# mrbc
$ git clone --depth=1 https://github.com/mruby/mruby.git
$ cd mruby
$ make
$ echo "export PATH=\"$HOME/mruby/bin:$PATH\"" >> "$HOME/.bashrc"
```
