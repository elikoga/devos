{ ssh-keys, ... }:
# recommend using `hashedPassword`
{
  users.users.root.openssh.authorizedKeys.keys = ssh-keys.root;
}
