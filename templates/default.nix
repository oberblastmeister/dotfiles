let mkTemplate = path: {
  inherit path;
  description = "";
};
in
{
  haskell = mkTemplate ./haskell;
}
