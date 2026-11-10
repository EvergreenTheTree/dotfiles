My Essential Software
=====================

This is a list of software that I find myself using very regularly.

# Desktop / Laptops

## Command Line

- fish: My favorite shell currently.
- tmux: My choice of terminal multiplexer.
- **[LINUX]** kitty: My favorite terminal emulator. Konsole / Yakuake is good too if you are using KDE.
- ripgrep: better `grep`
- fd: better `find`
- bat: better `cat`
- eza: better `ls`
- fzf: Really nice fuzzy finder / selector UI for the terminal.
- difftastic: Semantically aware diffs, needed for default difftool in git config.
- yazi: Really nice command line file manager.
- moreutils: Mainly for `vidir` and `vipe`, really great for renames and ad-hoc text processing stuff.
- jq: JSON manipulation tools.
- wl-clipboard: Wayland clipboard access.

## Web

- Firefox: My web browser of choice.
- Thunderbird: My email client of choice.
- Bittorrent Client _(Transmission, qBittorrent, KTorrent, etc)_
- Wireguard: Good simple VPN.

## Dev

### General

- neovim: My current choice of code editor.
- git: The version control system I am most familiar with.
- **[WINDOWS]** msys2: Linux on windows, mainly for compiling things.
- **[WINDOWS]** wsl2 w/Arch Linux: Linux on windows, mainly for actual command line use.
- Exuberant ctags: Necessary for some vim plugins.
- ImHex: Really great hex editor and general binary file inspector.
- Ghidra: When I need to pull out the big (reverse) guns. Thanks NSA!

### Python

- python 3.4+: I do a lot of stuff with python, so it is essential.
- pip: Much better python package management than easy_install, also essential.
- ipython: The best interactive python interpreter, no question.
- uv: Solves basically every problem I had with python dependency management.
- ty: Type checking language server.
- ruff: Code formatting and linting.
- pipx: Nice way of installing applications using pip without disrupting everything else.

### C/C++
- C/C++ compiler _(gcc, clang)_: For C hacking.
- clangd: C/C++ language server.
- bear: Generates command list for clangd (not needed if using CMake or meson).
- CMake: A really popular alternative to configure scripts.
- meson: Much better than CMake (though it is a low bar to clear tbf).

### Shell

- shellcheck: Shell script linter.

### Web

- oxipng: PNG optimizer.
- sass: CSS preprocessor that I mainly use for variables (though with CSS variables that is becoming unnecessary).

## Office

- LibreOffice: Great office suite that can handle most document formats
- Geogebra: Wonderful tool for exploring geometry and algebra
- **[LINUX]** Atril PDF Viewer: The best light-weight pdf viewer for gnome that I could find,
  though evince is okay. I would use okular on KDE.
- **[WINDOWS]** Sumatra PDF: Another PDF viewer.  It is the only good open source viewer
  I could find for windows, though it is kind of ugly.
- Pandoc: An awesome document converter.
- Veracrypt: Encrypted vault for sensitive documents.

## Multimedia

- Audacity: Best audio editor out there.
- Feishin: Client of choice for my navidrome server.
- Strawberry: My local music player of choice.
- OBS: Just a great all-around streaming/recording tool
- mpv: Extremely customizable lightweight video player, better than VLC IMO.
- VLC: My second favorite video player, supports every audio/video format under the sun
- GIMP: A really nice advanced image editing tool.
- Inkscape: Vector graphics editor.
- **[WINDOWS]** sharex: The best screenshot utility I could find for windows.
- Bitwig: best DAW on linux
- ffmpeg: Swiss army knife command line tool and library for audio and video.
- Imagemagick: Same but for images.
- Blender: Excellent all-around 3d-modeling and general compositing software.
- spek: Quickly check fishy audio files via their spectrogram.
- Kdenlive: The only open source video editor (tm).
- Kid3: KDE audio metadata editor.
- K3b: CD ripping.
- qpwgraph: My preferred pipewire routing GUI.
- coppwr: In-depth pipewire GUI mainly for troubleshooting or developing scripts.
- beets: Manage and autotag my music library.

## Chat

- Discord: I know it's bad privacy-wise but some communities I'm in use it exclusively.
- Vesktop: Better Discord client for the desktop (allows audio sharing on Linux when streaming).
- Signal: My preferred communication channel when I can get people to use it.

## System

- KDE Connect: Really nice set of tools for interacting with an Android phone (notifications, sending files, sharing clipboard, etc.)
- **[LINUX]** fuzzel: Extremely light-weight wayland keyboard launcher.
- **[LINUX]** htop: A really nice TUI task manager.
- **[LINUX]** Baobab or FileLight: Nice disk usage visualization.
- **[LINUX]** GParted or KPartition: Graphical partition editor.
- **[LINUX]** SUSE Studio Image Writer: Very simplistic image writer.
- **[WINDOWS]** Win32DiskImager: Gui `dd` for windows.
- **[WINDOWS]** Rufus: USB Image Writer.
- rsync: Simple file synchronization.
- Syncthing: Syncs things.
- restic: Good good backups.
- b2: Utility for configuring the location of the aforementioned good good backups.
- **[WINDOWS]** AutoHotkey: Awesome key remapping software.  _(also a
  programming language)_
- **[WINDOWS]** AHK Studio: Nice AutoHotkey script editor written in AutoHotkey.
- PuTTY: SSH/Telnet client and terminal emulator, plus much more.
- **[WINDOWS]** WinSCP: Great FTP client that doesn't bundle adware in its installer
- **[WINDOWS]** Powertoys: Lots of stuff that should just be built into Windows tbh.
- **[WINDOWS]** Everything: File search that ACTUALLY WORKS.

## Linux Distributions

- Arch Linux _(or EndeavourOS)_: My personal favorite.
- Ubuntu _(any spinoff)_: The best for compatibility.
- **[Ventoy]**: Nice tool for creating multi-distro USB drives.

## Window Managers and Desktop Environments

- KDE: My personal favorite.
- niri: My favorite tiling window manager.
  - hyprlock: hyprland is problematic but this is the nicest standalone lockscreen I've found.
  - swayidle: Enables the use of hyprlock.
  - mako: Standalone desktop notifications daemon.
  - waybar: Standalone wayland desktop toolbar.
  - waypaper + awww: GUI wallpaper manager.
  - brightnessctl: Control monitor brightness.
  - cliphist: Wayland clipboard manager.
- Xfce: My favorite light-weight stacking window manager/DE.

## Fonts

- Microsoft Core Fonts: A necessary evil.

## Games

- Steam: Games n stuff
- Simon Tatham's Puzzle Collection: The best collection of puzzles ever.
- OpenTTD: A really fun tycoon game.
- Warzone 2100: My favorite RTS game.
- PolyMC: For when I want to play Minecraft (which is almost never these days)
- XMoto: A fun _(completely unrealistic)_ 2d motocross game.

## Misc

- **[WINDOWS]** F.lux: Does what redshift does on windows.
- **[LINUX]** Safe Eyes: Application which reminds me to rest my eyes occasionally.
- **[WINDOWS]** Eye Leo: Does what Safe Eyes does on windows.

# Self-hosted

- Nix OS: Almost everything runs via Nix OS because being able to declaritively configure all services RULES (except when it's a massive pain).
- Wireguard: Everything I don't want publicly accessible goes through here.
- Nginx: Web server. Always liked the config syntax of it more than Apache.
- goaccess: Lightweight log monitoring for Nginx.
- FreshRSS: RSS feed reader.
- Navidrome: My own personal Spotify (lots of stuff on here that's not on streaming too).
- Git: Right now no forge frontend like Forgejo, just plain git.
- Immich: Spot-on Google Photos replacement.
- slskd + beet for autotagging / lyrics / replaygain: ;)
- qbittorrent + vuetorrent: Legit do not use this to pirate, just seeding my own large torrents as well as a few others.
- Actual: Really nice budgeting and finance management web application.
- thelounge: IRC web client that plays nicely with mobile. IMO nicer than trying to use bouncers + native clients.
- Syncthing: Acts as an always on proxy of sorts so clients like my desktop and phone don't need to be on all the time to sync. Also synchronizes things from slskd.
- dnsmasq: Give VPN-only services DNS names.
- Step CA: Local certificate authority for those DNS names so I can run them over TLS.

# Android

I use GrapheneOS on a Pixel 8a. Asterisks indicate apps only on Google Play.

- [AntennaPod](https://f-droid.org/en/packages/de.danoeh.antennapod/): My favorite podcatcher (though I don't listen to podcasts as much these days).
- [Audio Recorder](https://f-droid.org/en/packages/com.dimowner.audiorecorder/): How I record samples out in the wild as well as, musical ideas, tracking voice progress, etc.
- [Aves Libre](https://f-droid.org/en/packages/deckers.thibault.aves.libre/): Local photo gallery.
- \* [First Aid: American Red Cross](https://play.google.com/store/apps/details?id=com.cube.arc.fa): Emergency reference alongside Survival Manual.
- [BirthDayDroid](https://f-droid.org/en/packages/com.tmendes.birthdaydroid/): How I remember people's birthdays (along with setting them in my contacts).
- [DAVx5](https://f-droid.org/en/packages/at.bitfire.davdroid/): CalDAV and CardDAV synchronization for my personal calendar and contacts.
- \* [Discord](https://play.google.com/store/apps/details?id=com.discord): A kind of necessary very useful evil.
- [Bitwarden](https://mobileapp.bitwarden.com/fdroid/repo): My password manager (I don't self-host this because I don't trust myself like that).
- [Equate](https://f-droid.org/en/packages/com.llamacorp.equate/): Handy unit conversion (and general) calculator.
- [F-Droid](https://f-droid.org/en/packages/org.fdroid.fdroid/): Break the bonds of Google Play, you have nothing to lose but your chains!
- [Folio](https://f-droid.org/packages/com.folio.reader/): Client for FreshRSS feed reader.
- [FairScan](https://f-droid.org/en/packages/org.fairscan.app/): Open source camera-based document scanner
- [Feeel](https://f-droid.org/en/packages/com.enjoyingfoss.feeel/): My exercise routine.
- [Fennec](https://f-droid.org/en/packages/org.mozilla.fennec_fdroid/): Firefox available through F-Droid.
- [Fossify Calendar](https://f-droid.org/en/packages/org.fossify.calendar/): Calendar app that does the job though it is a bit clunky in some ways.
- [Fossify Contacts](https://f-droid.org/en/packages/org.fossify.contacts/): Solid contacts app.
- [FUTO Keyboard](https://app.futo.org/fdroid/repo/): The best GBoard replacement I could find.
- \* [Glitch Lab](https://play.google.com/store/apps/details?id=com.ilixa.glitch): Really cool creative image editor that I wish was on desktop! have not done so yet, but definitely worth paying for.
- [GMaps WV](https://f-droid.org/en/packages/us.spotco.maps/): Web wrapper for Google Maps when OpenStreetMap doesn't cut it.
- [Hacker's Keyboard](https://f-droid.org/en/packages/org.pocketworkstation.pckeyboard/): Keyboard for use with `termux`.
- [Image Toolbox](https://f-droid.org/en/packages/ru.tech.imageresizershrinker/): Swiss army knive for image editing on mobile.
- [Immich](https://f-droid.org/en/packages/app.alextran.immich/): Spot-on Google Photos replacement that I self-host.
- [K9 Mail](https://f-droid.org/en/packages/com.fsck.k9/): Email client that just works.
- [KDE Connect](https://f-droid.org/en/packages/org.kde.kdeconnect_tp/): Really nice set of tools for interacting with an Android phone (notifications, sending files, sharing clipboard, etc.)
- [LibreOffice Viewer](https://f-droid.org/en/packages/org.documentfoundation.libreoffice/): View OpenOffice and Microsoft Office files.
- [Markor](https://f-droid.org/en/packages/net.gsantner.markor/): How I take notes on mobile.
- [Material Files](https://f-droid.org/en/packages/me.zhanghai.android.files/): File explorer.
- [Metronome](https://f-droid.org/en/packages/com.bobek.metronome/): Take a wild guess.
- [Open Camera](https://f-droid.org/en/packages/net.sourceforge.opencamera/): For when I need more fine-grained control over camera parameters.
- [Organic Maps](https://f-droid.org/en/packages/app.organicmaps/): OpenStreetMap client I use for driving and hiking.
- [OsmAnd~](https://f-droid.org/en/packages/net.osmand.plus/): OpenStreetMap client I use for better topography maps and fine grained planning.
- [Pano Scrobbler](https://kawaiidango.github.io/pano-scrobbler/fdroid/repo/?fingerprint=9954ECAB27F9FCE8290AC75A33F3DFE9FE5F6F5B8E6F33AD7F98307AC4D487BA): Publish music listening to LastFM + ListenBrainz.
- [Passchain](https://f-droid.org/en/packages/s1m.hwfido2provider/): Enable the use of my yubikey on Android.
- [Qalculate!](https://f-droid.org/en/packages/com.jherkenhoff.qalculate/): Android frontend for qalc; an extremely capable calculator.
- [Secure Photo Viewer](https://f-droid.org/en/packages/com.gtp.showapicturetoyourfriend/): Nice little lockscreen photo viewer for worry-free handoff of my phone when I want to show someone photos.
- [Semitone](https://f-droid.org/en/packages/mn.tck.semitone/): General musician's tool (metronome, piano keyboard, pitch detector).
- [Signal Generator](https://f-droid.org/en/packages/org.billthefarmer.siggen/): Generate test signals for testing audio stuff.
- [Simon Tatham's Puzzles](https://f-droid.org/en/packages/name.boyle.chris.sgtpuzzles/): Android port of the best collection of puzzles ever.
- [SMS Import / Export](https://f-droid.org/en/packages/com.github.tmo1.sms_ie/): Backup my text messages.
- \* [Signal](https://play.google.com/store/apps/details?id=org.thoughtcrime.securesms): Signal refuses to distribute via F-Droid so here we are.
- [Survival Manual](https://f-droid.org/en/packages/org.ligi.survivalmanual/): Offline replacement for the Boy Scout handbook.
- \* [Symfonium](https://symfonium.app/): The best Android Navidrome Android client I could find. Paid, but worth every penny. Effectively acts like an even better Spotify for my personal library with automatically transcoded offline file supprot.
- [Syncthing-Fork](https://f-droid.org/en/packages/com.github.catfriend1.syncthingfork/): Technically a fork but now really the only option for Syncthing on Android.
- [Tasks.org](https://f-droid.org/en/packages/org.tasks/): How I manage all my todos (synchronized with DAVx5).
- [Termux](https://f-droid.org/en/packages/com.termux/): Command line environment on Android which I generally use to log in to my self-hosted servers to fix issues.
- [Vault Explorer](https://f-droid.org/en/packages/com.aeidolon.vaultexplorer/): Access my VeraCrypt vault(s) on Android.
- [VLC](https://f-droid.org/en/packages/org.videolan.vlc/): mpv doesn't really exist on Android, so this is de-facto the best media player.
- [whoBIRD](https://f-droid.org/en/packages/org.woheller69.whobird/): Bird call identification when hiking. Sometimes I try to get it to recognize my whistling.
- \* [Weawow](https://play.google.com/store/apps/details?id=com.weawow): Weather! Tried Breezy Weather but it didn't have UV and air quality.
- [WG Tunnel](https://fdroid.wgtunnel.com/): Wireguard on my phone so I can access those self-hosted services.

Other:
- NVIDIA SHIELD TV and Onkyo Controller apps: Remote control apps for my Nvidia Shield TV and Onkyo Audio receiver
- Banking apps (Venmo, Paypal, credit unions): Self explanatory.
- Mobile carrier app
- Google Messages: There just aren't any other apps that do RCS properly.
- Google Wallet: For Offline concert / show tickets mainly.
- WIFI Control App: My ISP unfortunately requires this, though it does everything I need it to.
- Printer App
- {insert health org here} app

# Not Self-Hosted

- Email / Calendar / TODO: Tried once and gave up; IP trust sucks.
- Bitwarden: Again, don't trust myself to secure this properly (plus I pay for FIDO2 auth support)
