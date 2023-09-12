local status_ok, mason = pcall(require, "mason")
if not status_ok then
	print("Error: mason")
	return
end

mason.setup({
    -- The directory in which to install packages.
    --install_root_dir = path.concat { vim.fn.stdpath "config", "mason" },
    install_root_dir = vim.g.config_path .. "/mason",
    ui = {
        check_outdated_packages_on_open = false,
        border = "rounded",
        icons = {
            -- The list icon to use for installed packages.
            package_installed = " ",
            -- The list icon to use for packages that are installing, or queued for installation.
            package_pending = " ",
            -- The list icon to use for packages that are not installed.
            package_uninstalled = " ",
        },

        keymaps = {
            -- Keymap to expand a package
            toggle_package_expand = "<CR>",
            -- Keymap to install the package under the current cursor position
            install_package = "i",
            -- Keymap to reinstall/update the package under the current cursor position
            update_package = "u",
            -- Keymap to check for new version for the package under the current cursor position
            check_package_version = "c",
            -- Keymap to update all installed packages
            update_all_packages = "U",
            -- Keymap to check which installed packages are outdated
            check_outdated_packages = "C",
            -- Keymap to uninstall a package
            uninstall_package = "X",
            -- Keymap to cancel a package installation
            cancel_installation = "<C-c>",
            -- Keymap to apply language filter
            apply_language_filter = "<C-f>",
        },
    },
})
