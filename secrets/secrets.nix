let
  eikster = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINJdBV35he63Px4V/wGdEkvtj5OFlAcX4f/ovc9dePHa";
  users = [
    eikster
  ];

  mibzy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBZ2UYhiZFvD1/Pnk59wFJUTyDQg/gYy0skWOBRCr3Bm";
  servers = [
    mibzy
  ];

  all = users ++ servers;
in
{
  "eikster.age".publicKeys = [ eikster ];
  "mibzy_tailscale.age".publicKeys = [ eikster mibzy ];
  "mibzy_meilisearch_key.age".publicKeys = [ eikster mibzy ];
}
