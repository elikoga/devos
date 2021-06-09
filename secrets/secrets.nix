let
  # set ssh public keys here for your system and user
  think-fennec = "";
  red-fennec = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFHtaObi0gAy0sjp9VoidFI6eOnjWHO+yL19+VxXmTR0 red-fennec";
  red-fennec-windows = "";
  allKeys = [ red-fennec ];
in
{
  "secret.age".publicKeys = allKeys;
}
