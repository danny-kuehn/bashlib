#!/usr/bin/env bash
#
#  colors.sh - A Bash module for colored text output.
#
#  Copyright (C) 2024  Daniel Kuehn <daniel@kuehn.foo>
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Affero General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU Affero General Public License for more details.
#
#  You should have received a copy of the GNU Affero General Public License
#  along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

colors_enable()  { BASHLIB_COLORS_ENABLED="true";  }
colors_disable() { BASHLIB_COLORS_ENABLED="false"; }

print_black()   { __colors_print "$(black_str   "$*")"; }
print_red()     { __colors_print "$(red_str     "$*")"; }
print_green()   { __colors_print "$(green_str   "$*")"; }
print_yellow()  { __colors_print "$(yellow_str  "$*")"; }
print_blue()    { __colors_print "$(blue_str    "$*")"; }
print_magenta() { __colors_print "$(magenta_str "$*")"; }
print_cyan()    { __colors_print "$(cyan_str    "$*")"; }
print_white()   { __colors_print "$(white_str   "$*")"; }
print_bold()    { __colors_print "$(bold_str    "$*")"; }

black_str()   { __colors_color_str "black"   "$*"; }
red_str()     { __colors_color_str "red"     "$*"; }
green_str()   { __colors_color_str "green"   "$*"; }
yellow_str()  { __colors_color_str "yellow"  "$*"; }
blue_str()    { __colors_color_str "blue"    "$*"; }
magenta_str() { __colors_color_str "magenta" "$*"; }
cyan_str()    { __colors_color_str "cyan"    "$*"; }
white_str()   { __colors_color_str "white"   "$*"; }
bold_str()    { __colors_color_str "bold"    "$*"; }

__colors_init() {
	declare -g BASHLIB_COLORS_ENABLED="true"
	declare -grA BASHLIB_COLORS=(
		["black"]="${BASHLIB_COLORS_BLACK:-\e[30m}"
		["red"]="${BASHLIB_COLORS_RED:-\e[31m}"
		["green"]="${BASHLIB_COLORS_GREEN:-\e[32m}"
		["yellow"]="${BASHLIB_COLORS_YELLOW:-\e[33m}"
		["blue"]="${BASHLIB_COLORS_BLUE:-\e[34m}"
		["magenta"]="${BASHLIB_COLORS_MAGENTA:-\e[35m}"
		["cyan"]="${BASHLIB_COLORS_CYAN:-\e[36m}"
		["white"]="${BASHLIB_COLORS_WHITE:-\e[37m}"
		["bold"]="${BASHLIB_COLORS_BOLD:-\e[1m}"
	)
	declare -grA BASHLIB_COLORS_OFF=(
		["black"]="${BASHLIB_COLORS_OFF_BLACK:-\e[39m}"
		["red"]="${BASHLIB_COLORS_OFF_RED:-\e[39m}"
		["green"]="${BASHLIB_COLORS_OFF_GREEN:-\e[39m}"
		["yellow"]="${BASHLIB_COLORS_OFF_YELLOW:-\e[39m}"
		["blue"]="${BASHLIB_COLORS_OFF_BLUE:-\e[39m}"
		["magenta"]="${BASHLIB_COLORS_OFF_MAGENTA:-\e[39m}"
		["cyan"]="${BASHLIB_COLORS_OFF_CYAN:-\e[39m}"
		["white"]="${BASHLIB_COLORS_OFF_WHITE:-\e[39m}"
		["bold"]="${BASHLIB_COLORS_OFF_BOLD:-\e[22m}"
	)
}

__colors_print() { printf >&2 "%s\n" "$1"; }

__colors_color_str() {
	local color="$1"
	local string="$2"
	local color_on="${BASHLIB_COLORS[$color]}"
	local color_off="${BASHLIB_COLORS_OFF[$color]}"

	if [[ "$BASHLIB_COLORS_ENABLED" == "true" ]]; then
		printf "%b%s%b" "$color_on" "$string" "$color_off"
	else
		printf "%s" "$string"
	fi
}

__colors_init
