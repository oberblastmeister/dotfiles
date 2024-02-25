use xshell::{cmd, Shell};

use anyhow::Result;

pub fn run(sh: &Shell, packages: &[String]) -> Result<()> {
    let packages = packages.join(" ");
    sh.write_file(
        "./shell.nix",
        format!("\
with import <nixpkgs> {{}}; mkShell {{
  packages = [ {packages} ];
}}
"),
    )?;
    sh.write_file("./.envrc", "use nix\n")?;
    cmd!(sh, "direnv allow").run()?;
    Ok(())
}
