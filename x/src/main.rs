mod use_nix;
mod clean_nix;
mod dot;

use clap::Parser;
use xshell::Shell;

#[derive(Parser, Debug)]
pub enum Command {
    UseNix {
        #[arg(short, long)]
        packages: Vec<String>,
    },
    CleanNix {},
    Dot,
}

fn main() -> anyhow::Result<()> {
    let sh = Shell::new()?;
    use Command::*;
    match Command::parse() {
        UseNix { packages } => use_nix::run(&sh, &packages),
        CleanNix {  } => clean_nix::run(&sh),
        Dot { } => dot::run(&sh),
    }
}
