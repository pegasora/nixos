# 📖 Full Installation Guide

**You need Nmap**. If you have Kali Linux or Parrot OS installed, you already have Nmap. If not, [follow the nmap install guide](https://nmap.org/download).

The easiest way to install RustScan is to use one of the packages provided for your system, such as HomeBrew or Yay for Arch Linux.

The most universal way is to use `cargo`, Rust's built in package manager (think Pip but for Rust). [Follow this guide to installing Rust & Cargo](https://doc.rust-lang.org/cargo/getting-started/installation.html).

If you face any issues at all, please leave a GitHub issue. I have only tested this on Linux, so there may be issues for Mac OS or Windows.

Note: sometimes Rust doesn't add Cargo to the path. Please see [this issue](https://github.com/rust-lang/rustup/issues/2436) for how to fix that.

## Docker 🐋

Docker is the recommended way of installing RustScan. This is because:

- It has a high open file descriptor limit, which is one of the [main problems](https://github.com/RustScan/RustScan/issues/40) with RustScan. Now you don't have to fiddle around trying to understand your OS.
- It works on all systems, regardless of OS. Even Windows, which we don't officially support.
- The Docker image uses the latest build from Cargo, our main source-of-truth package. This means that you will always be using the latest version.
- No need to install Rust, Cargo, or Nmap.

To install Docker, [follow their guide](https://docs.docker.com/engine/install/).

**Once Docker is installed, you can either build your own image using the `Dockerfile` (alpine) provided in the repo, or alternatively, use the published Docker image like below (most convenient)**

Please see our [DockerHub](https://hub.docker.com/repository/docker/rustscan/rustscan) for further our published versions. However, we recommend using our latest **major** release [2.1.1](https://github.com/RustScan/RustScan/releases/tag/2.1.1)

```
Stable and supported: rustscan/rustscan:2.1.1

Bleeding edge (run at your own risk!): rustscan/rustscan:latest
```

We strongly recommend using the `2.1.1` tag, as this is the latest major - stable - release of RustScan. This README uses the `2.1.1` image by default, however, note that the `latest` image is considered experimental. You can use all releases of Docker by visiting the [DockerHub Tags](https://hub.docker.com/r/rustscan/rustscan/tags) and replacing the command with the tag you desire. i.e. `docker pull rustscan/rustscan:1.10.0` can be `docker pull rustscan/rustscan:1.6.0`

#### To get started:

Simply run this command against the IP you want to target:

```bash
docker run -it --rm --name rustscan rustscan/rustscan:2.1.1 <rustscan arguments here>
```

Note: this will scan the Docker's localhost, not your own (unless using the
[_Host network driver_](https://docs.docker.com/engine/network/drivers/host/)).

Once done, you will no longer need to re-download the image (except when RustScan updates) and can use RustScan like a normal application.

You will have to run this command every time, so we suggest aliasing it to something memorable.

```bash
alias rustscan='docker run -it --rm --name rustscan rustscan/rustscan:2.1.1'
```

Then we can scan:

```bash
rustscan --addresses 192.168.1.0/24 -t 500 -b 1500 -- -A
```

#### To build your own image:

Download the repo:

```bash
git clone https://github.com/RustScan/RustScan.git
```

Ensure you navigate to the download location of the repo:

```bash
cd /path/to/download/RustScan
```

Build away!

```bash
docker build -t <yourimagename> .
```

## 🖥️ Debian / Kali

Download the .deb file from the releases page:

[https://github.com/RustScan/RustScan/releases](https://github.com/RustScan/RustScan/releases)

Run the command `dpkg -i` on the file.

Note: sometimes you can double click the file to achieve the same result.

## Docker :whale:

Docker is the recommended way of installing RustScan. This is because:

- It has a high open file descriptor limit, which is one of the [main problems](https://github.com/RustScan/RustScan/issues/40) with RustScan. Now you don't have to fiddle around trying to understand your OS.
- It works on all systems, regardless of OS. Even Windows, which we don't officially support.
- The Docker image uses the latest build from Cargo, our main source-of-truth package. This means that you will always be using the latest version.
- No need to install Rust, Cargo, or Nmap.

To install Docker, [follow their guide](https://docs.docker.com/engine/install/).

**Once Docker is installed, you can either build your own image using the `Dockerfile` (alpine) provided in the repo, or alternatively, use the published Docker image like below (most convenient)**

Please see our [DockerHub](https://hub.docker.com/repository/docker/rustscan/rustscan) for further info, however, note that we have two Docker images:

```
rustscan/rustscan:alpine

rustscan/rustscan:latest
```

We strongly recommend using the `alpine` tag, as this is the latest major - stable - release of RustScan. This README uses the `alpine` image by default, however, note that the`latest` image is considered experimental.

#### To get started:

Simply run this command against the IP you want to target:

```bash
docker run -it --rm --name rustscan rustscan/rustscan:alpine <rustscan arguments here> <ip address to scan>
```

Note: this will scan the Docker's localhost, not your own.

Once done, you will no longer need to re-download the image (except when RustScan updates) and can use RustScan like a normal application.

You will have to run this command every time, so we suggest aliasing it to something memorable.

```bash
alias rustscan='docker run -it --rm --name rustscan rustscan/rustscan:alpine'
```

Then we can:

```bash
rustscan 127.0.0.1 -t 500 -b 1500 -- -A
```

#### To build your own image:

Download the repo:

```bash
git clone https://github.com/RustScan/RustScan.git
```

Ensure you navigate to the download location of the repo:

```bash
cd /path/to/download/RustScan
```

Build away!

```bash
docker build -t <yourimagename> .
```

## 🍺 HomeBrew

**Note for Mac users** Mac OS has a very, very small ulimit size. This will negatively impact RustScan by a significant amount. Please use the Docker container, or tell RustScan to up the ulimit size on every run.

Tap the brew:

```bash
brew install rustscan
```

## 📱 Android/termux
Termux user can install *rustscan* via Package manager (pkg).
```bash
pkg install rustscan
```

## 🔧 Building it yourself

1. Git clone the repo.
2. Install Rust. You can do this with `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh` which I took from the Rust website [https://www.rust-lang.org/tools/install]()
3. cd into the Git repo, and run `cargo build --release`
4. The binary is located at `target/release/rustscan`
5. Symlink to the binary or something. Whatever you want!

## 🦊 Community Distributions

Here are all of RustScan's community distributions.

If you maintain a community distribution and want it listed here, leave an issue / pull request / Discord message or however you want to let us know.

- [OpenSuse](https://software.opensuse.org/package/rustscan?search_term=rustscan)
- [Fedora/CentOS](https://copr.fedorainfracloud.org/coprs/atim/rustscan/)

[![Packaging status](https://repology.org/badge/vertical-allrepos/rustscan.svg)](https://repology.org/project/rustscan/versions)
