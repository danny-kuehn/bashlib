#!/usr/bin/env bash
#
#  logging.sh - A Bash module for logging.
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

print_fatal()   { __logging_print "FATAL"   "$*"; }
print_error()   { __logging_print "ERROR"   "$*"; }
print_warn()    { __logging_print "WARN"    "$*"; }
print_info()    { __logging_print "INFO"    "$*"; }
print_debug()   { __logging_print "DEBUG"   "$*"; }
print_verbose() { __logging_print "VERBOSE" "$*"; }

log_fatal()   { __logging_log "FATAL"   "$*"; }
log_error()   { __logging_log "ERROR"   "$*"; }
log_warn()    { __logging_log "WARN"    "$*"; }
log_info()    { __logging_log "INFO"    "$*"; }
log_debug()   { __logging_log "DEBUG"   "$*"; }
log_verbose() { __logging_log "VERBOSE" "$*"; }

log_fatal_file()   { __logging_log_file "FATAL"   "$1" "${*:2}"; }
log_error_file()   { __logging_log_file "ERROR"   "$1" "${*:2}"; }
log_warn_file()    { __logging_log_file "WARN"    "$1" "${*:2}"; }
log_info_file()    { __logging_log_file "INFO"    "$1" "${*:2}"; }
log_debug_file()   { __logging_log_file "DEBUG"   "$1" "${*:2}"; }
log_verbose_file() { __logging_log_file "VERBOSE" "$1" "${*:2}"; }

set_log_level() {
	local level="${1:-}"

	if [[ ! -v "BASHLIB_LOG_LEVELS[$level]" ]]; then	
		printf >&2 "set_log_level: invalid log level: %s\n" "$level"
		return 1
	fi

	BASHLIB_LOG_LEVEL="${BASHLIB_LOG_LEVELS[$level]}"
}

__logging_init() {
	declare -g BASHLIB_LOG_LEVEL=3
	declare -g BASHLIB_LOG_TIME_FORMAT="%F %T"
	declare -grA BASHLIB_LOG_LEVELS=(
		[FATAL]=0
		[ERROR]=1
		[WARN]=2
		[INFO]=3
		[DEBUG]=4
		[VERBOSE]=5
	)
	declare -grA BASHLIB_LOG_COLORS=(
		[FATAL]="red"
		[ERROR]="red"
		[WARN]="yellow"
		[INFO]="blue"
		[DEBUG]="cyan"
		[VERBOSE]="magenta"
	)
}

__logging_print() {
	local level="$1"
	local message="$2"
	local level_color="${BASHLIB_LOG_COLORS[$level]}"
	local colored_level

	[[ "${BASHLIB_LOG_LEVELS[$level]}" -gt "$BASHLIB_LOG_LEVEL" ]] && return 0

	colored_level="$(__logging_add_color "$level_color" "[$level]")"

	printf >&2 "%s %s\n" "$colored_level" "$message"
}

__logging_log() {
	local level="$1"
	local message="$2"
	local level_color="${BASHLIB_LOG_COLORS[$level]}"
	local colored_level
	local datetime

	[[ "${BASHLIB_LOG_LEVELS[$level]}" -gt "$BASHLIB_LOG_LEVEL" ]] && return 0

	colored_level="$(__logging_add_color "$level_color" "[$level]")"
	datetime="$(printf "%($BASHLIB_LOG_TIME_FORMAT)T" -1)"

	printf >&2 "%s %s %s\n" "$datetime" "$colored_level" "$message"
}

__logging_log_file() {
	local level="$1"
	local file="${2:-}"
	local message="$3"
	local datetime

	if [[ -z "$file" ]]; then
		printf >&2 "__logging_log_file: no file provided"
		return 1
	fi

	[[ "${BASHLIB_LOG_LEVELS[$level]}" -gt "$BASHLIB_LOG_LEVEL" ]] && return 0

	datetime="$(printf "%($BASHLIB_LOG_TIME_FORMAT)T" -1)"

	printf "%s [%s] %s\n" "$datetime" "$level" "$message" >> "$file"
}

__logging_add_color() {
	local color="$1"
	local string="$2"
	local color_func

	if [[ -t 2 && "${BASHLIB_COLORS_ENABLED:-}" == "true" ]]; then
		color_func="${color}_str"
		"$color_func" "$string"
		return 0
	fi

	printf "%s" "$string"
}

__logging_init
