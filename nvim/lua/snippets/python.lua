return {
    s(
        'main',
        fmt(
            [[def main() -> None:
    {}

if __name__ == '__main__':
    main()
]],
            { i(1) }
        )
    ),
}
