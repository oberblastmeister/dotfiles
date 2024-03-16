use anyhow::Result;
use xshell::{cmd, Shell};

pub fn run(sh: &Shell) -> Result<()> {
    cmd!(sh, "git add .").run()?;
    cmd!(sh, "git commit -m '.'").run()?;
    Ok(())
}
