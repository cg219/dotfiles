return {
        'mbbill/undotree',
    config = function ()
        nmap("<leader>u", ":UndotreeToggle<cr>")
        nmap("<leader>ut", ":Undotree<cr>")
    end
}
