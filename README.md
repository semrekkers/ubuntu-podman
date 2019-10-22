# Ubuntu podman

Podman distribution for Ubuntu.

**Tested on Ubuntu 19.10**

### Install dependencies

```
sudo apt install \
    libgpgme11 \
    libyajl2 \
    policykit-1 \
    dbus-x11 \
    uidmap
```

### Enable swap accounting and unified cgroup2

Append the following to `GRUB_CMDLINE_LINUX` in `/etc/default/grub`:

    swapaccount=1 systemd.unified_cgroup_hierarchy=1

Update grub afterwards using `sudo update-grub`.
