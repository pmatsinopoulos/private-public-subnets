# How to generate an EC2 key pair

```
$ ssh-keygen -m PEM
```

Make sure the `id_rsa` files are created in the current directory.

Don't give a passphrase.

This process will generate `id_rsa` and `id_rsa.pub` in the current directory.

Run this command to make the `id_rsa` file read-only:

```
chmod u-w+r,g-rwx,o-rwx id_rsa
```

Then, terraform file [ec2_key_pair.tf](./ec2_key_pair.tf) is used to import the file into AWS.

The project requires 2 pairs.

1. `id_rsa` for connection from local laptop/machine to ec2-2 machine in the public subnet.
1. `id_rsa_internal` for connection from ec-2 machine to ec2-1 machine in the private subnet.
