# colors.sh

A simple color module for Bash scripts.

## Usage

Source the file in your script:

```bash
source colors.sh
```

### Colors

#### Default Text Colors

- Black: `\e[30m`
- Red: `\e[31m`
- Green: `\e[32m`
- Yellow: `\e[33m`
- Blue: `\e[34m`
- Magenta: `\e[35m`
- Cyan: `\e[36m`
- White: `\e[37m`
- Color off: `\e[39m`

#### Default Text Attributes

- Bold: `\e[1m`
- Bold off: `\e[22m`

#### Custom Text Colors

If you wish to override any of the color values, set the appropriate variable
before sourcing:

```bash
COLORS_BLUE="\e[38;2;0;0;255m" # Blue RGB
source colors.sh
```

`__colors_init()`: Automatically sets up color settings upon sourcing. The
                   color override variable names are set there.

### Global Variables

Upon initialization, `3` global variables are set:

- `COLORS_ENABLED`: A string variable set to `true`.
- `COLORS`: A read-only associative array containing ANSI color codes.
- `COLORS_OFF`: A read-only associative array containing ANSI color codes to
                turn off the respective colors.

### Functions

#### Enable/Disable Color Functions

You can toggle colors on and off in your scripts by invoking the following
functions:

```bash
colors_enable
```

```bash
colors_disable
```

#### Print Functions

These functions print colored strings of text to stderr, ensuring that stdout
remains unaffected. Each function automatically appends a newline character.

```bash
print_black "Text"
print_red "Text"
print_green "Text"
print_yellow "Text"
print_blue "Text"
print_magenta "Text"
print_cyan "Text"
print_white "Text"
print_bold "Text"
```

#### String Functions

These functions output colored strings of text to stdout without appending a
newline character. This allows the text to be captured into variables for
further use.

```bash
black_text="$(black_str "Text")"
red_text="$(red_str "Text")"
green_text="$(green_str "Text")"
yellow_text="$(yellow_str "Text")"
blue_text="$(blue_str "Text")"
magenta_text="$(magenta_str "Text")"
cyan_text="$(cyan_str "Text")"
white_text="$(white_str "Text")"
bold_text="$(bold_str "Text")"
```
