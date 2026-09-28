$ErrorActionPreference = "Stop"

$OSS = "C:\oss-cad-suite\bin"

$env:Path = "$OSS;C:\oss-cad-suite\lib;$env:Path"
$ProjectDir = "D:\project\learn_tang\fun_rv32i"
$Build = Join-Path $ProjectDir "build"
if (Test-Path $Build) {
    Remove-Item $Build -Recurse -Force
}

New-Item -ItemType Directory -Path $Build | Out-Null

Push-Location $Build

try {
    yosys -p "read_verilog ../src/rv32i_main.v ../src/rv32i_alu.v ../src/rv32i_memory.v ../src/rv32i_decoder.v; synth_gowin -top top -json cpu.json"


    nextpnr-himbaechel `
        --json cpu.json `
        --write pnrcpu.json `
        --device GW1NR-LV9QN88PC6/I5 `
        --vopt family=GW1N-9C `
        --vopt cst=../src/fun_rv32i.cst


    gowin_pack `
        -d GW1N-9C `
        -o cpu.fs `
        pnrcpu.json


    openFPGALoader -b tangnano9k cpu.fs
}
finally {
    Pop-Location
}
