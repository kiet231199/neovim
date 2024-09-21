#!/bin/bash

INSTALL_PATH=""
OPTION="--help"
CONFIG=""
LSP=""
TOOLS=""
VALID="true"

##############################
#     Define function        #
##############################

function show_help() {
    echo "./install <option> <package>: Select option and package"
    echo "./install --help   : Show help"
    echo "          --install: Install nvim and tools into your selected directory"
    echo "          --cleanup: Removed nvim and tools from your selected directory"
    echo "                     --all   : All below options"
    echo "                     --config: Configuration only"
    echo "                     --lsp   : LSP and Debug adapter"
    echo "                     --tool  : Required tools"
    echo "You can pass many packages in one time"
}

function get_install_path() {
    # Get installation path
    echo -n "Select installation path: "
    read INSTALL_PATH
    if [[ "${INSTALL_PATH}" == ~* ]]; then INSTALL_PATH="${INSTALL_PATH/#\~/$HOME}"; fi
    if [[ ! -d ${INSTALL_PATH} ]]; then echo "[FAILED] Invalid installation path" && exit 1; fi
}

function cleanup_config() {
    # Old cache
    if [ -d ${HOME}/.cache/nvim ]; then rm -rf ${HOME}/.cache/nvim; fi
    if [ -d ${HOME}/.local/share/nvim ]; then rm -rf ${HOME}/.local/share/nvim; fi
    if [ -d ${HOME}/.local/state/nvim ]; then rm -rf ${HOME}/.local/state/nvim; fi
    echo "[DONE] Removed cache"
    # Configuration files
    if [ -d ${HOME}/.config/nvim ]; then rm -rf ${HOME}/.config/nvim; fi
    if [ -d ${INSTALL_PATH}/config/nvim ]; then rm -rf ${INSTALL_PATH}/config/nvim; fi
    if [ -d ${INSTALL_PATH}/config/lazy ]; then rm -rf ${INSTALL_PATH}/config/lazy; fi
    echo "[DONE] Removed configuration"
}

function cleanup_LSP() {
    if [ -d ${INSTALL_PATH}/config/mason ]; then rm -rf ${INSTALL_PATH}/config/mason; fi
    if [ -d ${INSTALL_PATH}/config/dap ]; then rm -rf ${INSTALL_PATH}/config/dap; fi
    echo "[DONE] Removed language server"
}

function cleanup_tools() {
    if [ -d ${INSTALL_PATH}/tools ]; then rm -rf ${INSTALL_PATH}/tools; fi
    if [ -f ${HOME}/.bashrc_nvim ]; then rm ${HOME}/.bashrc_nvim; fi
    sed -i '/if \[ -f ${HOME}\/\.bashrc_nvim \]; then source ${HOME}\/\.bashrc_nvim; fi/d' ${HOME}/.bashrc
    echo "[DONE] Removed tools"
}

function cleanup() {
    # Remove configuration
    if [[ ${OPTION} == "all" ]] || [[ ${CONFIG} == "true" ]]; then cleanup_config; fi

    # Remove language server
    if [[ ${OPTION} == "all" ]] || [[ ${LSP} == "true" ]]; then cleanup_LSP; fi

    # Remove tools
    if [[ ${OPTION} == "all" ]] || [[ ${TOOLS} == "true" ]]; then cleanup_tools; fi

    # Final, just remove the empty config directory
    cd ${INSTALL_PATH}/config
    if [ ! -d dap ] && [ ! -d mason ] && [ ! -d lazy ] && [ ! -d nvim ]; then rm -rf ${INSTALL_PATH}/config; fi
}

function install_config() {
    cd ${WORK}
    # Configuration
    if [ ! -d ${INSTALL_PATH}/config ]; then mkdir -p ${INSTALL_PATH}/config; fi
    cp -r ${WORK}/config/nvim ${WORK}/config/lazy ${INSTALL_PATH}/config
    cd ${INSTALL_PATH}/config/lazy
    for pack in $(ls); do tar xf ${pack}; done
    # Loader
    mkdir -p ${HOME}/.config/nvim
    cp -r ${WORK}/rtp/* ${HOME}/.config/nvim
    sed -i "s|~/neovim/config/nvim|${INSTALL_PATH}/config/nvim|g" ${HOME}/.config/nvim/init.lua
    echo "[DONE] Installed configuration"
}

function install_LSP() {
    cd ${WORK}
    if [ ! -d ${INSTALL_PATH}/config ]; then mkdir -p ${INSTALL_PATH}/config; fi
    # Debugger Adapter
    cp -r ${WORK}/config/dap ${INSTALL_PATH}/config
    cd ${INSTALL_PATH}/config/dap
    tar xf pack.tar.bz2 && rm pack.tar.bz2
    echo "[DONE] Installed Debugger adapters"
    # Language servers
    cp -r ${WORK}/config/mason ${INSTALL_PATH}/config
    cd ${INSTALL_PATH}/config/mason
    tar xf pack.tar.bz2 && rm pack.tar.bz2
    cd packages
    for pack in $(ls); do tar xf ${pack} && rm ${pack}; done
    find . -type f ! -name "*.cfg" -exec sed -i "s|/home/kietpham/neovim|${INSTALL_PATH}|g" {} +
    echo "[DONE] Installed Language servers"
}

function install_tools() {
    cd ${WORK}
    cp -r ${WORK}/tools ${INSTALL_PATH}
    cd ${INSTALL_PATH}/tools
    for pack in $(ls | grep tar); do tar xf ${pack} && rm ${pack}; done
    echo "#!/bin/bash" >> ${HOME}/.bashrc_nvim
    echo "export PATH=\"${INSTALL_PATH}/tools/${dir}:\$PATH\"" >> ${HOME}/.bashrc_nvim
    for dir in $(ls -d */)
    do
        if [[ ${dir} != *git* ]]; then echo "export PATH=\"${INSTALL_PATH}/tools/${dir}bin:\$PATH\"" >> ${HOME}/.bashrc_nvim; fi
    done
    echo "export PATH=\"${INSTALL_PATH}/config/mason/bin:\$PATH\"" >> ${HOME}/.bashrc_nvim
    if [ ${SHELL} == *bash ]; then echo "if [ -f \${HOME}/.bashrc_nvim ]; then source \${HOME}/.bashrc_nvim; fi" >> ${HOME}/.bashrc; fi
    if [ ${SHELL} == *zsh ]; then echo "if [ -f \${HOME}/.bashrc_nvim ]; then source \${HOME}/.bashrc_nvim; fi" >> ${HOME}/.zshrc; fi
    echo "[DONE] Installed required tools"
}

function install() {
    # Check dependencies
    WORK=$(pwd)
    if [ ! -d ${WORK}/rtp ] || [ ! -d ${WORK}/config ] || [ ! -d ${WORK}/tools ]
    then
        echo "[FAILED] Missing pakages. Please check github repo kiet231199/neovim to download." && exit 1
    fi

    # Clean environment before installing
    cleanup

    # Install configuration
    if [[ ${OPTION} == "all" ]] || [[ ${CONFIG} == "true" ]]; then install_config; fi

    # Install language server
    if [[ ${OPTION} == "all" ]] || [[ ${LSP} == "true" ]]; then install_LSP; fi

    # Install tools
    if [[ ${OPTION} == "all" ]] || [[ ${TOOLS} == "true" ]]; then install_tools; fi
}


##############################
#     Main                   #
##############################

# Parse arguments
if [[ ${1} == "--install" ]] || [[ ${1} == "--cleanup" ]]; then OPTION=${1}; else OPTION="--help"; fi
shift # Remove the first argument
for arg in "$@"; do
    case "$arg" in
        *all*)
            CONFIG="true"
            LSP="true"
            TOOLS="true"
            ;;
        *config*)
            CONFIG="true"
            ;;
        *lsp*)
            LSP="true"
            ;;
        *tool*)
            TOOLS="true"
            ;;
        *)
            VALID=""
            ;;
    esac
done
if [[ "${VALID}" == "" ]]; then echo "Package invalid" && OPTION="--help"; fi

# Run
case "${OPTION}" in
    --install)
        get_install_path
        install
        ;;
    --cleanup)
        get_install_path
        cleanup
        ;;
    --help)
        show_help
        ;;
esac

