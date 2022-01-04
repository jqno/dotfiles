#!/bin/env bash

# Allows for the switching of certain specific configuration files between profiles.
#
# Available profiles should reside in a subdirectory under ~/.setEnv/, e.g. ~/.setEnv/home contains configuration
# for the profile 'home'. This profile can then be activated by invoking setEnv.sh home, which will apply
# GNU Stow under the hood.
# 
# Trying to switch to a profile that does not exist will have no effect.
#
#
# Configuring configuration files
# ===============================
#
# Place a file, with the complete path, that you want to be managed by the profile. For instance, if you want to
# manage an SSH config file, create a `.ssh` directory in your profile directory and place the `config` file in
# there. If you want to manage a Maven settings.xml, create a `.m2/settings.xml` file, etc. This script will create
# symlinks when the profile is activated.
#
#
# Configuring scripts
# ===================
#
# Place a folder called scripts in the profile directory to have its contents symlinked to ~/.env/scripts on
# profile activation. You can place ~/.env/scripts on the PATH so that any scripts contained within the directory
# will be available.
#
#
# Configuring a banner
# ====================
#
# If you want a banner to show up when you are switching to a profile, just create a file called banner inside
# the profile directory. It will be output to the terminal when switching to this profile. No file means no banner.
#
#
# Custom initialization
# =====================
#
# If you need more custom initialization for your profile, create a directory called .env inside the profile directory,
# and add a file called init.sh to it. It will be called once all the other profile configurations have been properly
# configured.
#
# If you need to clean up when leaving the current profile (for instance, if you need to shut down a docker container),
# create a file called .env/shutdown.sh inside the profile directory. It will be called right before switching to a new
# profile.
#
#
# Custom terminal session environment
# ===================================
#
# If you need to configure your terminal session environment, for instance if you want to define some environment
# variables or aliases specific to your profile, create a file called .env/session.sh inside the profile directory.
# It will be sourced every time your terminal starts.
#
# NOTE: to make that work, you have to add the following line to your .bashrc or .zshrc:
# 
#     source ~/.env/session.sh
#
#
# Injecting something into the prompt
# ===================================
#
# If you want to inject a symbol or some text into your prompt when a certain profile is active, add a file called
# .env/marker to your profile. For example, if your profile is called home, the file could contain this:
#
#     🏠
#
# Note that this script doesn't actually add it to your prompt; you need to arrange for that yourself.


# Setup

SETENVDIR="$HOME/.setEnv"
ENVDIR="$HOME/.env"
PROFILE_FILENAME="$SETENVDIR/active-profile"
PROFILE_NAME=$1
NEWENVDIR="$SETENVDIR/$PROFILE_NAME"
OLDPROFILENAME=$(cat "$PROFILE_FILENAME")


# Validate environment

if [[ -z "$PROFILE_NAME" ]]; then
  echo "No parameter"
  exit 1
fi

if [[ ! -d "$NEWENVDIR" ]]; then
  echo "New environment $NEWENVDIR does not exist"
  exit 1
fi


# Shutdown

if [[ -e $ENVDIR/shutdown.sh ]]; then
  echo "Shutting down current environment"
  . "$ENVDIR/shutdown.sh"
fi


# Activate profile

echo "Swapping to $NEWENVDIR"

pushd "$SETENVDIR" > /dev/null
if [[ -d "$SETENVDIR/$OLDPROFILENAME" ]]; then
  stow -D "$OLDPROFILENAME" 2> /dev/null # Need to redirect because of https://github.com/aspiers/stow/issues/65
fi

stow "$PROFILE_NAME"
echo "$PROFILE_NAME" > "$PROFILE_FILENAME"
popd > /dev/null


# Initialize profile

if [[ -e $ENVDIR/init.sh ]]; then
  . "$ENVDIR/init.sh"
fi

if [[ -e $NEWENVDIR/banner ]]; then
  cat "$NEWENVDIR/banner"
fi

. "$ENVDIR/session.sh"
