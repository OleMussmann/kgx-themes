# GNOME Console (kgx) theme patches for nix/nixOS

Give your terminal a splash of color. 🎨

Like the new GNOME Console? Dislike the harsh default color scheme? You can apply themes easily with patches in your `flake.nix` on nix/nixOS. Other operation systems can still use the patches, but you have to compile `kgx` yourself. Here be dragons.

## Patch Description

This repository contains 300+ patches of your favorite terminal themes with or without transparency. Patches come in two main flavors: "single" and "dual", with a varying transparency.

"single" patches have a single color scheme for light- and dark-mode, while "dual" patches combine two color schemes that are selectable via the Console menu or the system {light/dark} mode. The patch name is assembled as follows:

- single patch
  - [theme name].alpha_[transparency].patch

- single patch
  - [light theme name].alpha_[light theme transparency].[dark theme name].alpha_[dark theme transparency].patch

`transparency` is a float between 0 and 1, with 0 being fully transparent and 1 being opaque. The pre-compiled patches are available with `alpha=0.95` (slight transparency) and `alpha=1.00` (fully opaque).

## Choices, Choices, Choices

This repo contains everything available at https://terminal.sexy/ (check out the Scheme Browser), as well as the following additional themes:

- dark
  - Dracula
  - Nord
- light
  - Polar (Nord light)

## Usage

### Installation

Patch `kgx` in your nix config and install your tweaked package. Use either pre-build patches (cloud or local install), or create your own (local install).

#### Cloud

Easy approach, but limited to mostly mono themes.

- Get the right patch URL
  - Find your favorite theme in https://github.com/OleMussmann/kgx-themes/tree/main/patches Let's assume we want the dark theme "Ashes" with a transparency of `alpha=0.95`.
  - Click your way through to "dark" -> "ashes.alpha_0.95.patch". You should now be at https://github.com/OleMussmann/kgx-themes/blob/main/patches/dark/ashes.alpha_0.95.patch
  - Click on "Raw" and copy the URL. It should be https://raw.githubusercontent.com/OleMussmann/kgx-themes/main/patches/dark/ashes.alpha_0.95.patch
- Apply the patch in your `flake.nix` with `overrideAttrs` like so:
```
let kgx_patched = pkgs.kgx.overrideAttrs( oldAttrs: {
  patches = [ 
    (pkgs.fetchpatch {
      url = "https://raw.githubusercontent.com/OleMussmann/kgx-themes/main/patches/dark/ashes.alpha_0.95.patch";
      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    })
  ];
});

in {[your system config]}
```

- Install `kgx_patched` in your system config like any other package.
- The first build will fail. Replace the `sha256` with the correct one from the error message and re-build.

#### Local

More flexibility, you can use your own patches here. See below for generating those.

- Put the chosen patch in your repo, ideally in a dedicated subdirectory for patches.
- Apply the patch in your `flake.nix` with `overrideAttrs` like so:
```
let kgx_patched = pkgs.kgx.overrideAttrs( oldAttrs: { patches = [ RELATIVE_PATH_TO_PATCH/ashes.alpha_0.95.patch ]; } );

in {[your system config]}
```
- Install `kgx_patched` in your system config like any other package.

### Advanced
I won't polish this workflow for now. Hopefully GNOME Console will get native theming support at some point. 🙂

#### Create new themes
- Create a new source file under `generate/sources/web/{dark,light}`. Copy & paste an existing one and edit the filename and content.
- Create a theme file

    cd generate
    ./2_create_web_themes.sh

- Create your patches, see below.

#### Create mono patches
- Find a themes under `generate/themes/{dark,light}`.
- Execute

    ./create_mono_patch.sh [theme file] [theme transparency]

    Example:
    ./create_mono_patch.sh generate/themes/dark/solarized.theme 0.95

Copy the patch to your system repo and install locally, see above.

#### Create dual patches
- Find two themes under `generate/themes/{dark,light}`.
- Execute

    ./create_dual_patch.sh [light theme file] [light theme transparency] [dark theme file] [dark theme transparency]

    Example:
    ./create_dual_patch.sh generate/themes/light/atelierlakeside.theme 0.97 generate/themes/dark/hybrid.theme 0.97

Copy the patch to your system repo and install locally, see above.
