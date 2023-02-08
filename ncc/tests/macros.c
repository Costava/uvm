#define FOO()
#define BAR(x) x

#define BIF 1
#undef BIF
#define BIF 2

#define MACRO2(a, b) (a+b)

void main()
{
    // Macro with zero arguments
    FOO();
    FOO ();

    // Macro with one argument
    BAR(1);
    BAR((1));
    BAR((1, 2));
    BAR(3 + (1, 2));

    // Macro applied over multiple lines
    MACRO2(
        1,
        2
    );

    MACRO2(
        1, // comment in macro args
        2  /* multi-line comment */
    );

    // Regression: closing parens inside a string
    BAR(")");
    BAR("\")\"");
}
