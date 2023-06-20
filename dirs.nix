{ user }:

rec {
  naiveDir = "/home/" + user + "/dotfiles";
  naiveConfigDir = naiveDir + "/config";
  naiveBinDir = naiveDir + "/bin";
  naiveModulesDir = naiveDir + "/modules";
  naiveUserModulesDir = naiveDir + "/user_modules";
  dir = ./.;
  configDir = dir + "/config";
  binDir = dir + "/bin";
  modulesDir = dir + "/modules";
  userModulesDir = dir + "/user_modules";
}
