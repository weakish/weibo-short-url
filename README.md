command line client to weibo short url service.

Install
-------

```sh
; git clone https://github.com/weakish/weibo-short-url.git
; cd weibo-short-url
; make
```

It will install `weiboshurl` to `/usr/local/bin`.
Edit `config.mk` to customize installation path.

The Makefile is compatible with both GNU make and BSD make.

### Uninstall

```sh
; cd weibo-short-url
; make uninstall
```

Usage
-----

encode text to weibo short url

    echo 'abcdefg' | weiboshurl

decode

    weiboshurl http://t.cn/8smtzVX

It can encode arbitrary text, including encrypted text:

    echo 'abcdefg' | gpg --yes -r `whoami` -e | weiboshurl
    weiboshurl http://t.cn/8smtzVX | gpg -d

Due to the limit of weibo short url, this script cannot encode text
containing more than 1010 characters.

Q: Why not just use 'data:text/plain;base64'?
A: Because weibo short url service dose not recognize data urls.

License
-------

0BSD
