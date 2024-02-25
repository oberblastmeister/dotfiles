mod use_nix;
mod clean_nix;

use clap::Parser;
use xshell::Shell;

#[derive(Parser, Debug)]
pub enum Command {
    UseNix {
        #[arg(short, long)]
        packages: Vec<String>,
    },
    CleanNix {},
}

fn main() -> anyhow::Result<()> {
    let sh = Shell::new()?;
    match Command::parse() {
        Command::UseNix { packages } => use_nix::run(&sh, &packages),
        Command::CleanNix {  } => clean_nix::run(&sh),
    }
}
