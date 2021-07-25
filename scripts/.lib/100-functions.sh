__mark()
{
    printf >&2 '► “%s” \n' "$*"
    printf '► “%s” \n' "$*"
}

__print()
{
    printf "%s\\n" "$@"
}
