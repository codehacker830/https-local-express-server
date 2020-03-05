#!/bin/bash

rm *.crt
rm *.csr
rm *.key
rm *.p12
rm *.srl

# set values for certificate DNs
# note: CN is set to different values in the sections below
ORG="000_Test_Certificates"

# set values that the commands will share
VALID_DAYS=360
CA_KEY=ca.key
CA_CERT=ca.crt
SERVER_KEY=server.key
SERVER_CERT=server.crt
SERVER_CSR=server.csr
KEY_BITS=2048

echo
echo "Create CA certificate..."
CN="Test CA"
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:$KEY_BITS -out $CA_KEY
openssl req -new -x509 -days $VALID_DAYS -key $CA_KEY -subj "/CN=$CN/O=$ORG" -out $CA_CERT
echo "Done."

echo
echo "Creating Server certificate..."
CN="localhost"
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:$KEY_BITS -out $SERVER_KEY
openssl req -new -key $SERVER_KEY -subj "/CN=$CN/O=$ORG" -out $SERVER_CSR
openssl x509 -days $VALID_DAYS -req -in $SERVER_CSR -CAcreateserial -CA $CA_CERT -CAkey $CA_KEY -out $SERVER_CERT
echo "Done."

echo
echo "Creating Client certificate testuser1..."
CLIENT_KEY=testuser_1.key
CLIENT_CERT=testuser_1.crt
CLIENT_CSR=testuser_1.csr
CLIENT_P12=testuser_1.p12
CN="Test User 1"
USER_ID="testuser1"
P12_PASSWORD=
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:$KEY_BITS -out $CLIENT_KEY
openssl req -new -key $CLIENT_KEY -subj "/CN=$CN/O=$ORG/UID=$USER_ID" -out $CLIENT_CSR
openssl x509 -days $VALID_DAYS -req -in $CLIENT_CSR -CAcreateserial -CA $CA_CERT -CAkey $CA_KEY -out $CLIENT_CERT
openssl pkcs12 -in $CLIENT_CERT -inkey $CLIENT_KEY -export -password pass:$P12_PASSWORD -out $CLIENT_P12
echo "Done."

echo
echo "Creating Client certificate testuser2..."
CLIENT_KEY=testuser_2.key
CLIENT_CERT=testuser_2.crt
CLIENT_CSR=testuser_2.csr
CLIENT_P12=testuser_2.p12
CN="Test User 2"
USER_ID="testuser2"
P12_PASSWORD=
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:$KEY_BITS -out $CLIENT_KEY
openssl req -new -key $CLIENT_KEY -subj "/CN=$CN/O=$ORG/UID=$USER_ID" -out $CLIENT_CSR
openssl x509 -days $VALID_DAYS -req -in $CLIENT_CSR -CAcreateserial -CA $CA_CERT -CAkey $CA_KEY -out $CLIENT_CERT
openssl pkcs12 -in $CLIENT_CERT -inkey $CLIENT_KEY -export -password pass:$P12_PASSWORD -out $CLIENT_P12
echo "Done."

echo
echo "Creating Client certificate unknown..."
CLIENT_KEY=testuser_unknown.key
CLIENT_CERT=testuser_unknown.crt
CLIENT_CSR=testuser_unknown.csr
CLIENT_P12=testuser_unknown.p12
CN="Test User Unknown"
USER_ID="unknown"
P12_PASSWORD=
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:$KEY_BITS -out $CLIENT_KEY
openssl req -new -key $CLIENT_KEY -subj "/CN=$CN/O=$ORG/UID=$USER_ID" -out $CLIENT_CSR
openssl x509 -days $VALID_DAYS -req -in $CLIENT_CSR -CAcreateserial -CA $CA_CERT -CAkey $CA_KEY -out $CLIENT_CERT
openssl pkcs12 -in $CLIENT_CERT -inkey $CLIENT_KEY -export -password pass:$P12_PASSWORD -out $CLIENT_P12
echo "Done."

echo
echo "Creating Client certificate expired..."
CLIENT_KEY=testuser_expired.key
CLIENT_CERT=testuser_expired.crt
CLIENT_CSR=testuser_expired.csr
CLIENT_P12=testuser_expired.p12
CN="Test User Expired"
USER_ID="expired"
P12_PASSWORD=
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:$KEY_BITS -out $CLIENT_KEY
openssl req -new -key $CLIENT_KEY -subj "/CN=$CN/O=$ORG/UID=$USER_ID" -out $CLIENT_CSR
openssl x509 -days -1 -req -in $CLIENT_CSR -CAcreateserial -CA $CA_CERT -CAkey $CA_KEY -out $CLIENT_CERT
openssl pkcs12 -in $CLIENT_CERT -inkey $CLIENT_KEY -export -password pass:$P12_PASSWORD -out $CLIENT_P12
echo "Done."

echo
echo "Create invalid CA certificate..."
CA_KEY=ca2.key
CA_CERT=ca2.crt
CN="Test CA"
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:$KEY_BITS -out $CA_KEY
openssl req -new -x509 -days $VALID_DAYS -key $CA_KEY -subj "/CN=$CN/O=$ORG" -out $CA_CERT
echo "Done."

echo
echo "Creating Client certificate invalid..."
CLIENT_KEY=testuser_invalid.key
CLIENT_CERT=testuser_invalid.crt
CLIENT_CSR=testuser_invalid.csr
CLIENT_P12=testuser_invalid.p12
CN="Test User Invalid"
USER_ID="invalid"
P12_PASSWORD=
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:$KEY_BITS -out $CLIENT_KEY
openssl req -new -key $CLIENT_KEY -subj "/CN=$CN/O=$ORG/UID=$USER_ID" -out $CLIENT_CSR
openssl x509 -days $VALID_DAYS -req -in $CLIENT_CSR -CAcreateserial -CA $CA_CERT -CAkey $CA_KEY -out $CLIENT_CERT
openssl pkcs12 -in $CLIENT_CERT -inkey $CLIENT_KEY -export -password pass:$P12_PASSWORD -out $CLIENT_P12
echo "Done."

echo
echo "Remove files that we don't need..."
rm *.csr
rm *.srl
rm testuser_*.crt
rm testuser_*.key
rm ca*.key
echo "Done."

echo
echo "----- Don't forget to import your ca.crt and client .p12 certificates into your browser -----"
echo