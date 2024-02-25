use anyhow::Result;
use xshell::Shell;

pub fn run(sh: &Shell) -> Result<()> {
    if sh.path_exists("./shell.nix") {
        sh.remove_path("./shell.nix")?;
    }
    if sh.path_exists("./flake.nix") {
        sh.remove_path("./flake.nix")?;
    }
    if sh.path_exists("./flake.lock") {
        sh.remove_path("./flake.lock")?;
    }
    if sh.path_exists("./.envrc") {
        sh.remove_path("./.envrc")?;
    }
    Ok(())
}
