# How to generate an EC2 key pair

```
$ ssh-keygen -m PEM
```

Make sure the `id_rsa` files are created in the current directory.

Give a passphrase.

This process will generate `id_rsa` and `id_rsa.pub` in the current directory.

Run this command to make the `id_rsa` file read-only:

```
chmod u-w+r,g-rwx,o-rwx id_rsa
```

Then, terraform file [ec2_key_pair.tf](./ec2_key_pair.tf) is used to import the file into AWS.
