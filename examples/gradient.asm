# Data section
.data

# 800 * 600 * 3
PIXEL_BUFFER:
.zero 1_440_000

MS_STR:
.stringz " milliseconds to render\n"

# Code section
.code

# Local 0, 1, width and height
push_u32 800;
push_u32 600;

# Create the window
get_local 1;
get_local 0;
syscall window_create;
syscall window_show;

# Local 2: Y=0
push_u32 0;

# Local 3: X=0
push_u32 0;

# Start time in ms, local 4
syscall time_current_ms;

# For each row
LOOP_Y:

    # For each column
    # X = 0
    push_i8 0;
    set_local 3;
    LOOP_X:



    # Pixel address
    get_local 2; # Y
    push_u64 800;
    mul_i64;
    get_local 3;
    add_i64; # Y * 800 + X
    push_u64 3;
    mul_i64; # (Y * 800 + X) * 3
    dup;

    # Y * 256 / 600
    get_local 2;
    push_u64 256;
    mul_i64;
    push_u64 600;
    div_i64;
    store_u8;

    # Blue coordinate address
    push_i8 2;
    add_i64;

    # X * 256 / 800
    get_local 3;
    push_u64 256;
    mul_i64;
    push_u64 800;
    div_i64;
    store_u8;

    # X = X + 1
    get_local 3;
    push_i8 1;
    add_i64;
    set_local 3;

    # Loop until done writing pixels
    get_local 3;
    get_local 0;
    lt_i64;
    jnz LOOP_X;

# Y = Y + 1
get_local 2;
push_i8 1;
add_i64;
set_local 2;

# Loop for each row
get_local 2;
get_local 1;
lt_i64;
jnz LOOP_Y;

# End time in ms
syscall time_current_ms;

# Compute render time in ms
get_local 4;
sub_i64;

syscall print_i64;
push_p32 MS_STR;
syscall print_str;

push_p32 PIXEL_BUFFER;
syscall window_copy_pixels;

# Wait for an event
wait;

exit;