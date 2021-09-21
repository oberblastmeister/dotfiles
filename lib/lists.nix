{ ... }:
rec {
  concatMap = f: list: builtins.concatLists (map f list);
}
