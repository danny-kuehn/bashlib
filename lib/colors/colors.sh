#!/usr/bin/env bash
#
#  colors.sh - A simple color module for Bash scripts.
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

colors_enable()  { COLORS_ENABLED="true" ; }
colors_disable() { COLORS_ENABLED="false"; }

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
	declare -g COLORS_ENABLED="true"
	declare -grA COLORS=(
		["black"]="${COLORS_BLACK:-\e[30m}"
		["red"]="${COLORS_RED:-\e[31m}"
		["green"]="${COLORS_GREEN:-\e[32m}"
		["yellow"]="${COLORS_YELLOW:-\e[33m}"
		["blue"]="${COLORS_BLUE:-\e[34m}"
		["magenta"]="${COLORS_MAGENTA:-\e[35m}"
		["cyan"]="${COLORS_CYAN:-\e[36m}"
		["white"]="${COLORS_WHITE:-\e[37m}"
		["bold"]="${COLORS_BOLD:-\e[1m}"
	)
	declare -grA COLORS_OFF=(
		["black"]="${COLORS_OFF_BLACK:-\e[39m}"
		["red"]="${COLORS_OFF_RED:-\e[39m}"
		["green"]="${COLORS_OFF_GREEN:-\e[39m}"
		["yellow"]="${COLORS_OFF_YELLOW:-\e[39m}"
		["blue"]="${COLORS_OFF_BLUE:-\e[39m}"
		["magenta"]="${COLORS_OFF_MAGENTA:-\e[39m}"
		["cyan"]="${COLORS_OFF_CYAN:-\e[39m}"
		["white"]="${COLORS_OFF_WHITE:-\e[39m}"
		["bold"]="${COLORS_OFF_BOLD:-\e[22m}"
	)
}

__colors_print() {
	local string="$*"

	printf >&2 "%s\n" "$string"
}

__colors_color_str() {
	local color="$1"; shift
	local string="$*"

	if [[ "$COLORS_ENABLED" == "true" ]]; then
		printf "%b%s%b" "${COLORS[$color]}" "$string" "${COLORS_OFF[$color]}"
	else
		printf "%s" "$string"
	fi
}

__colors_init
