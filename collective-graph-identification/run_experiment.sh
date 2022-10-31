#!/bin/bash

function run_psl() {
    local outDir=$1
    local extraOptions=$2

    mkdir -p "${outDir}"

    local outPath="${outDir}/out.txt"
    local errPath="${outDir}/out.err"

    if [[ -e "${outPath}" ]]; then
        echo "Output file already exists, skipping: ${outPath}"
        return 0
    fi

    # Run PSL.
    ./cli/run.sh ${extraOptions} > "${outPath}" 2> "${errPath}"

    # Copy any artifacts into the output directory.
    cp -r cli/inferred-predicates "${outDir}/"
    cp cli/*.data "${outDir}/"
    cp cli/*.psl "${outDir}/"
}

function main() {
    trap exit SIGINT

    local experiment=$1

    local outDir="results/experiment::${experiment}"
    local extraOptions="-D runtime.log.level=DEBUG"

    run_psl "$outDir" "$extraOptions"
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"
