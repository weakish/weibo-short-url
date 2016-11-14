#!/usr/bin/env coffee

# Usage:
# encode text to weibo short url
#
#     echo 'abcdefg' | weiboshurl
#
# decode
#
#     weiboshurl http://t.cn/8smtzVX
#
# It can encode arbitrary text, including encrypted text:
#
#     echo 'abcdefg' | gpg --yes -r `whoami` -e | weiboshurl
#     weiboshurl http://t.cn/8smtzVX | gpg -d
#
# Due to the limit of weibo short url, this script cannot encode text
# containing more than 1010 characters.
#
# Q: Why not just use 'data:text/plain;base64'?
# A: Because weibo short url service dose not recognize data urls.


shelljs = require 'shelljs'
fs = require 'fs'

weibo_short_url = process.argv[2]
if weibo_short_url
  base64_encoded = shelljs.exec("curl #{weibo_short_url} |
    grep -o -E 'http://base64/[^\"]+' |
    sed -e 's#http://base64/##'",
    {silent: true}).output
  console.log(new Buffer(base64_encoded, "base64").toString())
else
  base64_encoded = fs.readFileSync('/dev/stdin').toString('base64')
  if base64_encoded + 'http://base64/'.length > 1024 # weibo short url limit
    console.log('Text can only contains at most 1010 characters!')
  else
    # weibo api requires access token, so I just use this free service
    weibo_shorten_url = "http://www.henshiyong.com/tools/sina-shorten-url.php"
    weibo_shorten_url_filter = "grep -o -E 'http://t\.cn\/[0-9a-zA-Z]+'"
    short_url = shelljs.exec("curl -d 'url=http://base64/#{base64_encoded}'
      -d 'submit=生成短链接' #{weibo_shorten_url} |
      #{weibo_shorten_url_filter}",
      {silent:true}).output
    console.log(short_url)
