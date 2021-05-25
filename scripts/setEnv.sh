#!/bin/env bash

# Allows for the switching of certain specific configuration files between profiles. Currently it supports:
#
# * Maven settings.xml (in ~/.m2/)
# * NPM resource file (in ~/.npmrc)
#
# Available profiles should reside in a subdirectory under ~/.setEnv/, e.g. ~/.setEnv/home contains configuration
# for the profile 'home'. This profile can then be activated by invoking setEnv.sh home
# 
# Trying to switch to a profile that does not exist will have no effect.
#
#
# Configuring Maven settings.xml
# ==============================
#
# Place a file called settings.xml in the profile directory to have it copied to ~/.m2/ on profile activation.
# Before copying the profile version, this script deletes the file at ~/.m2/settings.xml. This means if you do
# not put a settings.xml file in the profile directory, you will end up with a completely default Maven configuration.
#
#
# Configuring NPM resource file
# =============================
#
# There are two ways to switch between NPM resource files: copying files or use the npmrc tool.
#
# 1. Copying files : This works exactly the same as the Maven way described above. Place a file called npmrc
#                    in the profile directory. It will be copied to ~/.npmrc (yes the dot is added during copy).
#                    Leaving the file out will result in no ~/.npmrc file and hence a default NPM configuration
# 2. Using npmrc   : If you have the npmrc utility installed and configured with profiles, this utility can
#                    delegate to it. Create a file ~/.setEnv/use-npmrc to trigger this behavior. Once active,
#                    we either call npmrc with the name of the profile you are currently activating, or we
#                    pass npmrc the name of the profile you specify in the npmrc file inside the profile
#                    directory.
#
#
# Configuring scripts
# ===================
#
# Place a folder called scripts in the profile directory to have its contents symlinked to ~/.setEnv/scritps on
# profile activation. You can place ~/.setEnv/scripts on the PATH so that any scripts contained within the directory
# will be available.
#
#
# Configuring SSH
# ===============
#
# Place a folder called ssh in the profile directory to have its contents symlinked to ~/.ssh on profile activation.
# Before copying the profile version, this script removes the entire ~/.ssh directory. This means if you do not
# have an ssh folder in the profile directory, you will lose all of your ssh configuration.
#
# The directory is symlinked so that any edits you make will be persisted across sessions.
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
# If you need more custom initialization for your profile, create a file called init.sh inside the profile directory.
# It will be called once all the other profile configurations have been properly configured.
#
# If you need to clean up when leaving the current profile (for instance, if you need to shut down a docker container),
# create a file called shutdown.sh inside the profile directory. It will be called right before switching to a new
# profile.
#
# Custom terminal session environment
# ===================================
#
# If you need to configure your terminal session environment, for instance if you want to define some environment
# variables or aliases specific to your profile, create a file called session.sh inside the profile directory.
# It will be sourced every time your terminal starts.
#
# NOTE: to make that work, you have to add the following line to your .bashrc or .zshrc:
# 
#     source ~/.setEnv/session.sh
#
#
# Injecting something into the prompt
# ===================================
#
# If you want to inject a symbol or some text into your prompt when a certain profile is active, just set the
# SETENV_MARKER environment variable in your session.sh, for example:
#
#     export SETENV_MARKER=🏠
#
# For completeness, you can add the same text into the `marker` file. This is important if you want to
# make sure that the prompt knows when the environment was changed in another session: changed environment
# aren't propagated to other sessions, but files are.
#
# Note that this script doesn't actually add it to your prompt; you need to arrange for that yourself.

if [[ -z "$1" ]]; then
  echo "No parameter"
  exit 1
fi

SETENVDIR="$HOME/.setEnv"
ENVDIR="$SETENVDIR/$1"
if [[ ! -d "$ENVDIR" ]]; then
  echo "$ENVDIR does not exist"
  exit 1
fi

if [[ -e $SETENVDIR/shutdown.sh ]]; then
  echo "Shutting down current environment"
  . $SETENVDIR/shutdown.sh
fi

echo "Swapping to $ENVDIR"

if [[ -e $ENVDIR/marker ]]; then
  rm $SETENVDIR/marker
  cp $ENVDIR/marker $SETENVDIR/marker
fi

rm $SETENVDIR/scripts 2> /dev/null
if [[ -e $ENVDIR/scripts ]]; then
  ln -s $ENVDIR/scripts $SETENVDIR/scripts
fi

if [[ -e $HOME/.setEnv/use-npmrc ]]; then
  if [[ -e $ENVDIR/npmrc ]]; then
    npmrc `cat $ENVDIR/npmrc`
  else
    npmrc $1
  fi
else
  if [[ -e $ENVDIR/npmrc ]]; then
    rm ~/.npmrc
    cp $ENVDIR/npmrc ~/.npmrc
  fi
fi

if [[ -e $ENVDIR/settings.xml ]]; then
  rm ~/.m2/settings.xml
  cp $ENVDIR/settings.xml ~/.m2/settings.xml
fi

if [[ -e $ENVDIR/ssh ]]; then
  rm -rf ~/.ssh
  ln -s $ENVDIR/ssh ~/.ssh
fi

if [[ -e $SETENVDIR/session.sh ]]; then
  rm $SETENVDIR/session.sh
fi

if [[ -e $ENVDIR/session.sh ]]; then
  cp $ENVDIR/session.sh $SETENVDIR
fi

if [[ -e $SETENVDIR/shutdown.sh ]]; then
  rm $SETENVDIR/shutdown.sh
fi

if [[ -e $ENVDIR/shutdown.sh ]]; then
  cp $ENVDIR/shutdown.sh $SETENVDIR
fi

if [[ -e $ENVDIR/init.sh ]]; then
  . $ENVDIR/init.sh
fi

if [[ -e $ENVDIR/banner ]]; then
  cat $ENVDIR/banner
fi

source $ENVDIR/session.sh

