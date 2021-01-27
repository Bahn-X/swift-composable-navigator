find . -name '*.gyb' |                                                                   \
    while read file; do                                                                  \
        gyb                                                                              \
            --line-directive ''                                                          \
            -o "`dirname ${file%.gyb}`/Generated.`basename ${file%.gyb}`"                \
            "$file";                                                                     \
    done