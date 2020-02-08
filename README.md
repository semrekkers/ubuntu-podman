# Ubuntu podman

Podman redistribution for Ubuntu.

**Tested on Ubuntu 19.10**

## The package

This redistribution contains:

| Application                                                       | Version |
| ----------------------------------------------------------------- | ------- |
| [Podman](https://github.com/containers/libpod)                    | v1.8.0  |
| [crun](https://github.com/containers/crun)                        | 0.12.1  |
| [conmon](https://github.com/containers/conmon)                    | v2.0.10 |
| [slirp4netns](https://github.com/rootless-containers/slirp4netns) | v0.4.3  |
| [fuse-overlayfs](https://github.com/containers/fuse-overlayfs)    | v0.7.6  |
| [CNI plugins](https://github.com/containernetworking/plugins)     | v0.8.5  |
| [catatonit](https://github.com/openSUSE/catatonit)                | f700039 |

## Setup

### Install dependencies

```
sudo apt install \
    libgpgme11 \
    libyajl2 \
    policykit-1 \
    dbus-x11 \
    dbus-user-session \
    uidmap
```

### Enable swap accounting and unified cgroup2

Append the following to `GRUB_CMDLINE_LINUX` in `/etc/default/grub`:

    swapaccount=1 systemd.unified_cgroup_hierarchy=1

Update grub afterwards using `sudo update-grub`.
