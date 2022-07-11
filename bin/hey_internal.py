import os
import pathlib
import shutil
import subprocess
from pathlib import Path
from typing import Optional, TypeVar
import click

T = TypeVar("T")


def unwrap(optional: Optional[T]) -> T:
    if optional is None:
        raise TypeError("Optional value is None")
    return optional


def is_root() -> bool:
    return os.getuid() == 0


@click.group(invoke_without_command=True)
@click.version_option()
@click.pass_context
@click.option(
    "--flake",
    type=click.Path(exists=True),
    default=pathlib.Path(__file__).parent.parent.resolve(),
)
def cli(cx: click.Context, flake):
    """
    Helper for nix
    """
    if is_root():
        raise click.ClickException(
            "You must not be root. hey will ask you for your password when root is needed."
        )


@cli.command("gc")
def cli_gc():
    subprocess.run(["sudo", "nix-collect-garbage", "-d"])
    subprocess.run(["sudo", "nix-store", "--optimise"])


def run_rebuild(flake: Path, extra: list[str]):
    cmd = ["sudo", "nixos-rebuild", "--flake", flake] + extra
    subprocess.run(cmd)


def run_update(flake: Path):
    subprocess.run(["nix", "flake", "update", flake])


@cli.command("update")
@click.pass_context
def cli_update(cx: click.Context):
    run_update(unwrap(cx.parent).params["flake"])


@cli.command("upgrade")
@click.pass_context
def cli_upgrade(cx: click.Context):
    flake = unwrap(cx.parent).params["flake"]
    run_update(flake)
    run_rebuild(flake, ["switch"])


@cli.command("rollback")
@click.pass_context
def cli_rollback(cx: click.Context):
    run_rebuild(unwrap(cx.parent).params["flake"], ["--rollback", "switch"])


@cli.command("rebuild")
@click.pass_context
@click.argument("extra", nargs=-1)
def cli_rebuild(cx: click.Context, extra):
    run_rebuild(unwrap(cx.parent).params["flake"], list(extra))


def generate_hardware_config(root: Path, dir: Path) -> None:
    new_dir = dir
    if root != Path("/") and dir.is_relative_to(root):
        new_dir = Path("/") / dir.relative_to(root)
    subprocess.run(["nixos-generate-config", "--root", root, "--dir", new_dir])
    (dir / "configuration.nix").unlink()


@cli.command("push")
def cli_push():
    subprocess.run(["git", "add", "."])
    subprocess.run(["git", "commit", "-m", "."])
    subprocess.run(["git", "push"])


@cli.command("add-host")
@click.pass_context
@click.argument("hostname")
@click.option("--force", is_flag=True)
@click.option("--conf", type=click.Path(exists=True))
@click.option("--hardware-conf", type=click.Path(exists=True))
@click.option("--root", type=click.Path(exists=True))
def cli_add_host(
    cx: click.Context,
    hostname,
    force,
    conf,
    hardware_conf,
    root,
):
    flake = unwrap(cx.parent).params["flake"]
    if len(Path(hostname).parts) != 1:
        raise ValueError("The name must only have one path component")
    host_path = flake / "hosts" / hostname
    if host_path.exists():
        if force:
            shutil.rmtree(host_path)
        else:
            raise ValueError("The host path already exists")
    host_path.mkdir()
    try:
        if hardware_conf is None:
            generate_hardware_config(root or Path("/"), host_path)
        else:
            shutil.copy(hardware_conf, host_path / "hardware-configuration.nix")
        if conf is None:
            shutil.copy(flake / "host_template" / "default.nix", host_path)
        else:
            shutil.copy(conf, host_path / "default.nix")
    except Exception:
        try:
            host_path.rmdir()
        except Exception:
            pass
        raise
    subprocess.run(["git", "add", host_path])


@cli.command("update-dconf")
@click.option("--force", is_flag=True)
@click.pass_context
def cli_update_dconf(cx: click.Context, force):
    dconf_dir = Path(os.environ["DOTFILES_CONFIG"]) / "dconf"
    dconf_settings = dconf_dir / "dconf.settings"
    if dconf_settings.exists() and not force:
        raise click.ClickException("dconf.settings exists, pass --force to override it")
    with dconf_settings.open(mode="w") as file:
        subprocess.run(["dconf", "dump", "/"], stdout=file)
    dconf_nix = dconf_dir / "dconf.nix"
    if dconf_nix.exists() and not force:
        raise click.ClickException("dconf.nix exists, pass --force to override it")
    subprocess.run(["dconf2nix", "-i", dconf_settings, "-o", dconf_nix])


def main():
    cli()
