#!/usr/bin/env bash

# Run this file to create the secret yaml

export DB_USER="wikiuser"
export DB_NAME="my_wiki"
export DB_PASS="sqlpass"
export DB_SERVER="mediawiki-mysql.wikibase:3306"
export MW_ADMIN_NAME="admin"
export MW_ADMIN_PASS="adminpass"
export MW_ADMIN_EMAIL="admin@example.com"
export MW_WG_SECRET_KEY="secretkey"
export OAUTH_CONSUMER_KEY="559fcf1da153c5ec4b2fbefa7c3c395b"
export OAUTH_CONSUMER_SECRET="57cad33da0015dce1e94a597908e19848714a6af"
echo "DB_USER=${DB_USER}"
echo "DB_NAME=${DB_NAME}"
echo "DB_PASS=${DB_PASS}"
echo "DB_SERVER=${DB_SERVER}"
echo "MW_ADMIN_NAME=${MW_ADMIN_NAME}"
echo "MW_ADMIN_PASS=${MW_ADMIN_PASS}"
echo "MW_ADMIN_EMAIL=${MW_ADMIN_EMAIL}"
echo "MW_WG_SECRET_KEY=${MW_WG_SECRET_KEY}"
echo "OAUTH_CONSUMER_KEY=${OAUTH_CONSUMER_KEY}"
echo "OAUTH_CONSUMER_SECRET=${OAUTH_CONSUMER_SECRET}"



cat <<EOF > ./10-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: wikibase
  namespace: wikibase
type: Opaque
data:
  db.user: $(echo -n "${DB_USER}" | base64)
  db.name: $(echo -n "${DB_NAME}" | base64)
  db.pass: $(echo -n "${DB_PASS}" | base64)
  db.server: $(echo -n "${DB_SERVER}" | base64)
  mw.admin.name: $(echo -n "${MW_ADMIN_NAME}" | base64)
  mw.admin.pass: $(echo -n "${MW_ADMIN_PASS}" | base64)
  mw.admin.email: $(echo -n "${MW_ADMIN_EMAIL}" | base64)
  mw.wg.secret.key: $(echo -n "${MW_WG_SECRET_KEY}" | base64)
  oauth.consumer.key: $(echo -n "${OAUTH_CONSUMER_KEY}" | base64)
  oauth.consumer.secret: $(echo -n "${OAUTH_CONSUMER_SECRET}" | base64)
EOF
