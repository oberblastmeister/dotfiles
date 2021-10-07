{ self, lib, ... }:

let
  attrFromKeyList = keyList: {
    ${head keyList} = attrFromKeyList (builtins.tail keyList);
  };
in
{
  inherit attrFromKeyList;
}
