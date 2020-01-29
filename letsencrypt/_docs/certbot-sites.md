# Certbot logs

## Sites

plato.emptool.com
plato-dev-bot.plato.emptool.com
plato-trading-bot.plato.emptool.com
wordpress.plato.emptool.com
brahman-devops.plato.emptool.com

empere.plato.emptool.com 
csi.plato.emptool.com

## Get certs for multiple sites

sudo /usr/local/bin/certbot-auto certonly --manual -d plato-dev-bot.plato.emptool.com -d plato-trading-bot.plato.emptool.com

sudo /usr/local/bin/certbot-auto certonly --manual -d empere.plato.emptool.com -d csi.plato.emptool.com

## Merge into a single cert

certbot-auto certonly --manual -d plato.emptool.com -d plato-dev-bot.plato.emptool.com -d plato-trading-bot.plato.emptool.com -d wordpress.plato.emptool.com -d brahman-devops.plato.emptool.com -d empere.plato.emptool.com -d csi.plato.emptool.com

 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/plato-dev-bot.plato.emptool.com/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/plato-dev-bot.plato.emptool.com/privkey.pem
   Your cert will expire on 2020-04-28. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot-auto
   again. To non-interactively renew *all* of your certificates, run
   "certbot-auto renew"


/etc/letsencrypt/live/plato-dev-bot.plato.emptool.com/fullchain.pem

haproxy.plato_multi_name_cert.pem

# For deployment to Plato's HAPROXY, the private key needs to be concatentate to the cert.

cat example.com.crt example.com.key > example.com.pem

cat /etc/letsencrypt/live/plato-dev-bot.plato.emptool.com/fullchain.pem /etc/letsencrypt/live/plato-dev-bot.plato.emptool.com/privkey.pem > haproxy.plato_multi_name_cert.pem

## Logs

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Create a file containing just this data:

9_-FF9dWLRJnDrMtNmIuX5u8_InuigHST85cAssSyBs.JZjQfKRRkfGvNcvWBwuEmieQMxQa7eR38IvijYo7ZoM

And make it available on your web server at this URL:

http://plato.emptool.com/.well-known/acme-challenge/9_-FF9dWLRJnDrMtNmIuX5u8_InuigHST85cAssSyBs

 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/plato.emptool.com/fullchain.pem
   
   Your key file has been saved at:
   /etc/letsencrypt/live/plato.emptool.com/privkey.pem
   
   Your cert will expire on 2020-04-28. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot-auto
   again. To non-interactively renew *all* of your certificates, run
   "certbot-auto renew"

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Create a file containing just this data:

GeKAqLxwwLhgfymsXjVXsbGzWpI7OdDGQMicTc4SGqQ.JZjQfKRRkfGvNcvWBwuEmieQMxQa7eR38IvijYo7ZoM

And make it available on your web server at this URL:

http://plato-dev-bot.plato.emptool.com/.well-known/acme-challenge/GeKAqLxwwLhgfymsXjVXsbGzWpI7OdDGQMicTc4SGqQ

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Create a file containing just this data:

dAUxWtuuu3TbtpeZOBoQCoAqNpipiGhvfH6uZ1pPqMY.JZjQfKRRkfGvNcvWBwuEmieQMxQa7eR38IvijYo7ZoM

And make it available on your web server at this URL:

http://plato-trading-bot.plato.emptool.com/.well-known/acme-challenge/dAUxWtuuu3TbtpeZOBoQCoAqNpipiGhvfH6uZ1pPqMY

(This must be set up in addition to the previous challenges; do not remove,
replace, or undo the previous challenge tasks yet.)

 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/plato-dev-bot.plato.emptool.com/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/plato-dev-bot.plato.emptool.com/privkey.pem
   Your cert will expire on 2020-04-28. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot-auto
   again. To non-interactively renew *all* of your certificates, run
   "certbot-auto renew"


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Create a file containing just this data:

lwiMAdBncaC8q5sKXosJULPw8h1BeCc4Cd2zPVBv9ME.JZjQfKRRkfGvNcvWBwuEmieQMxQa7eR38IvijYo7ZoM

And make it available on your web server at this URL:

http://brahman-devops.plato.emptool.com/.well-known/acme-challenge/lwiMAdBncaC8q5sKXosJULPw8h1BeCc4Cd2zPVBv9ME

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Create a file containing just this data:

MTreOSQnfMXz5yLLFXYZWA5MduUIZihWFzpIVAdPYEE.JZjQfKRRkfGvNcvWBwuEmieQMxQa7eR38IvijYo7ZoM

And make it available on your web server at this URL:

http://wordpress.plato.emptool.com/.well-known/acme-challenge/MTreOSQnfMXz5yLLFXYZWA5MduUIZihWFzpIVAdPYEE

(This must be set up in addition to the previous challenges; do not remove,
replace, or undo the previous challenge tasks yet.)

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Create a file containing just this data:

lfTvGsmN644tB1UNm8bKdamW4G7Yem73qzx-QjYsXXo.JZjQfKRRkfGvNcvWBwuEmieQMxQa7eR38IvijYo7ZoM

And make it available on your web server at this URL:

http://csi.plato.emptool.com/.well-known/acme-challenge/lfTvGsmN644tB1UNm8bKdamW4G7Yem73qzx-QjYsXXo

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Create a file containing just this data:

DkHpRpXhluGh-pa-zfAWaiXPiHkNUElBTimDtgpmslk.JZjQfKRRkfGvNcvWBwuEmieQMxQa7eR38IvijYo7ZoM

And make it available on your web server at this URL:

http://empere.plato.emptool.com/.well-known/acme-challenge/DkHpRpXhluGh-pa-zfAWaiXPiHkNUElBTimDtgpmslk

(This must be set up in addition to the previous challenges; do not remove,
replace, or undo the previous challenge tasks yet.)

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
