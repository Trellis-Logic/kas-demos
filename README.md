# Kas demo scripts

Scripts used to demonstrate various kas builds

## Setup

```
pip3 install kas
```

## Usage

```
config=myconfig
mkdir build-${project}
cd build-${project}
kas build --update ../kas/${project}.yml
```

where `${project}` is a specific kas configuration to demo
from the list of .yml files in the [kas](kas) subdir
and outlined below

## Building Alternate Branches

The default branch build configuration is for master/main on each project.

To build for alternate branches, use the `kas/include/${branch}` file on
the config file list as outlined in the [kas build commandline instructions](https://kas.readthedocs.io/en/latest/userguide/project-configuration.html#including-configuration-files-via-the-command-line)

So for example, to build the swupdate-oe4t project for kirkstone branch, use
```
kas build --update ../kas/swupdate-oe4t.yml:../kas/include/kirkstone.yml
```

## Demo Projects

### swupdate-oe4t

A demo of the [Swupdate for NVIDIA Tegra](https://github.com/OE4T/tegra-demo-distro/tree/master/layers/meta-tegrademo/dynamic-layers/meta-swupdate)
layer from tegra-demo-distro.  See the README there for details.

### swupdate-rootfs-overlay-oe4t

A demo of the swupdate-oe4t project with the addition of a read only rootfs with overlay
and /data partition for non-volatile storage.
