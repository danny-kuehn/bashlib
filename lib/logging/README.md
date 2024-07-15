# logging.sh

A Bash module for logging.

## Usage

Source the file in your script:

```bash
source logging.sh
```

### Global Variables

Upon initialization, `4` global variables are set:

- `BASHLIB_LOG_LEVEL`: Set to `3`. This sets the log level to `INFO`.
- `BASHLIB_LOG_TIME_FORMAT`: Set to `%F %T`. This controls the date/time format
                             in the log functions.
- `BASHLIB_LOG_LEVELS`: A read-only associative containing the different log
                        levels and their respective numeric value.
- `BASHLIB_LOG_COLORS`: A read-only associative array containing color names for
                        each log level.

### Colored Log Levels

If you include the `colors` module from this repository, the output will contain
colored log levels.

### Functions

#### Set Log Level

You can set a specific log level using the `set_log_level` function like so:

```bash
set_log_level "ERROR"
```

This will suppress all output except `ERROR` and `FATAL` level logs.

#### Printing Functions

These functions print log messages without timestamps:

```bash
print_fatal   "This is a fatal error message"
print_error   "This is an error message"
print_warn    "This is a warning message"
print_info    "This is an info message"
print_debug   "This is a debug message"
print_verbose "This is a verbose message"
```

#### Logging Functions

These functions print log messages with timestamps:

```bash
log_fatal   "This is a fatal error message"
log_error   "This is an error message"
log_warn    "This is a warning message"
log_info    "This is an info message"
log_debug   "This is a debug message"
log_verbose "This is a verbose message"
```

#### Log To File Functions

These functions log messages to a specified file (with timestamps):

```bash
log_fatal_file   "file.log" "This is a fatal error message"
log_error_file   "file.log" "This is an error message"
log_warn_file    "file.log" "This is a warning message"
log_info_file    "file.log" "This is an info message"
log_debug_file   "file.log" "This is a debug message"
log_verbose_file "file.log" "This is a verbose message"
```
