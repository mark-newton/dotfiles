#!/bin/bash
# Settings to init OSX

## For ease of iterative experimentation
doo () {
    echo $@
    $@
}

# Stop bouncing icons in dock
doo defaults write com.apple.dock no-bouncing -bool FALSE;

# Enable font smoothing
doo defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
doo defaults -currentHost write -globalDomain AppleFontSmoothing -int 2

# Show hidden files in finder
doo defaults write com.apple.finder AppleShowAllFiles YES
