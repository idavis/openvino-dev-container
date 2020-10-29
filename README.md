# openvino-dev-container
OpenVino development container definition for the VS Code Remote - Containers extension and GitHub Codespaces

## Getting Started

### Requirements

- [Visual Studio Code](https://code.visualstudio.com/)
- [Remote - Containers Extension for VS Code](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Quick Start

1. Clone this repo
2. Start VS Code, run the Remote-Containers: Open Folder in Container... command from the Command Palette (F1) or quick actions Status bar item, and select the folder you cloned into.

## Technical Details

The base image can be changed via the build args in the `devcontainer.json`. The defaults are as follows:
```json
    "args": { "BASE": "openvino/ubuntu18_dev", "TAG": "2021.1", "USERNAME": "openvino" }
```

Note: it is not recommended to change the username as the official OpenVino images rely on it.

## Smoke Test

To verify that everything is working, try running the demo benchmark in the container.

```
 /opt/intel/openvino/deployment_tools/demo/demo_benchmark_app.sh -d <TARGET>
```

Where `<TARGET>` is one of `CPU`, `GPU`, `FPGA`, `HDDL` or `MYRIAD` depending on the devices you have available.

## Linux

This repository is designed to run against CPU, Intel GPU, Myriad (Neural Compute Stick 2 (`NCS2`)), and HDDL targets. Some of these targets require additional host configuration. `NCS2` can be configured with `make install-myriad` which will install the `udev` rules and conigure the host. For HDDL. see the [HDDL device configuration guide](https://github.com/openvinotoolkit/docker_ci/blob/master/install_guide_vpu_hddl.md).

In order to run against the `NCS2` target, the container must be run with `--device-cgroup-rule='c 189:* rmw'` and `-v /dev/bus/usb:/dev/bus/usb`.

NCS2:
```json
    "runArgs": ["--net=host", "--device-cgroup-rule", "c 189:* rmw", "--cap-add=SYS_PTRACE", "--security-opt", "seccomp=unconfined"],
```

GPU:
```json
    "runArgs": ["--net=host", "--device=/dev/dri:/dev/dri", "--cap-add=SYS_PTRACE", "--security-opt", "seccomp=unconfined"],
```

HDDL:

```json
    "runArgs": ["--net=host", "--device=/dev/ion:/dev/ion", "-v", "/var/tmp:/var/tmp", "--cap-add=SYS_PTRACE", "--security-opt", "seccomp=unconfined"],
```

## Windows and MacOS

Only CPU targets can be used which require no additional device configuration. The Intel GPU, Myriad (Neural Compute Stick 2 (`NCS2`)), and HDDL targets are unavailable on Windows and MacOS.

In the `devcontainer.json` set the `runArgs` as follows which will allow for C++ development and remove the `/dev/bus/usb` configuration from the `mounts` section:
```json
    "runArgs": ["--cap-add=SYS_PTRACE", "--security-opt", "seccomp=unconfined"],
```

## Miscellaneous

The Major/Minor device version numbers for `--device-cgroup-rule` can be found at the [kernel.org devices](
https://www.kernel.org/doc/Documentation/admin-guide/devices.txt) page.