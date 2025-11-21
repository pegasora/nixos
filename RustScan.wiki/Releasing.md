# Who can release
On Discord, Kaeros and Bee both have release perms for all major platforms. Typically Bee releases, but Kaeros can also release.

# Versioning
We use semantic versioning for our releases. This means major implies a major breaking change, minor implies a potential minor change / feature request, bug fix implies bug fixes and no breaking changes.

# When we release
We aim to release regularly. 
* Major releases

Only when we have a major breaking change.

* Minor

Whenever a new feature is added. It is okay for us to release twice in one day, so long as the features are significant enough.

* Bug Fixes

We normally include these in minor releases.

# Releasing Debian Files

Run `./run.sh` in `rustscan-debbuilder` folder. It will produce 3 debs in a sub-folder.

# Releasing Arch
Git clone the arch repo

```
git clone ssh://aur@aur.archlinux.org/rustscan.git
```

Bump the version number & replace the checksum with the `.tar.gz` checksum.

Generated a .srcinfo

```
makepkg --printsrcinfo > .SRCINFO
```

git add, git commit, git push.

# Releasing on HomeBrew
No idea, yet.

# Docker
It's automated, don't worry about it.

# Cargo

```
Cargo Publish
```
