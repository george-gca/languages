if [[ $# -gt 0 ]]; then
    n_runs=$1
else
    n_runs=5
fi

if hash hyperfine 2>/dev/null; then
    echo "Running $(basename $PWD) benchmark"
    hyperfine --setup 'bash ../compile.sh' --cleanup 'bash ../clean.sh' --runs $n_runs --export-markdown "$(basename $PWD).md" \
        './dart/code 40' \
        './go/code 40' \
        'java jvm.code 40' \
        'java -jar kotlin/code.jar 40' \
        'node ./js/code.js 40' \
        'php ./php/code.php 40' \
        'python3 ./py/code.py 40'
        'Rscript ./r/code.R 40' \
        'ruby ./ruby/code.rb 40' \
        './rust/target/release/code 40'
        # './c/code 40' \
        # 'bun ./js/code.js 40' \
        # 'deno ./js/code.js 40' \
        # 'pypy ./py/code.py 40' \
else
    echo "hyperfine is not installed. Please refer to https://github.com/sharkdp/hyperfine for installation instructions."
fi
