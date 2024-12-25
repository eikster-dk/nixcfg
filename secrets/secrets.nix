let
  eikster = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINJdBV35he63Px4V/wGdEkvtj5OFlAcX4f/ovc9dePHa";
  users = [
    eikster
  ];

  web1 = "";
  web2 = "";
  dedi1 = "";
  servers = [
    web1
    web2
    dedi1
  ];

  all = users ++ servers;
in
{
  "eikster.age".publicKeys = [ eikster ];
}
