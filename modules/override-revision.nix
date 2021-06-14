{ lib, ... }: {
  system.nixos.revision = lib.mkForce null;
}
